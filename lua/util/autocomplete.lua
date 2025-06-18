local dmp = require("util.diff")
local group = "Stab"
local curl = require("plenary.curl")
local logger = require("util.logger")
local F = vim.fn

local ns_id = vim.api.nvim_create_namespace("Stab")
local ext_ids = {}
local cache = {}

local H = {}
local M = {}
local S = {
  retries = 0,
  max_retries = 3,
  suggestion = {
    range = {},
    content = nil,
    available = false,
    ext_id = nil,
    line = 1,
    buf_id = nil,
    diff = nil,
  }
}

local CONFLICT_START = "<<<<<<< HEAD"
local CONFLICT_SEP = "======="
local CONFLICT_END = ">>>>>>>"

local cbuf = require("util.cbuf")
local last_buf_state = {}
local edit_history = cbuf:new(2)

au("ModeChanged", "*", function(ev)
  local old, new = unpack(vim.split(ev.match, ":"))
  local cur_buf_state = H.get_lines()
  logger.debug("Current buf:", cur_buf_state)
  logger.debug("Last buf:", last_buf_state)

  if old == "n" then
    last_buf_state = cur_buf_state
  elseif new == "n" then
    -- replace unified diff with git conflict markup
    local idx = vim.diff(H.concat(last_buf_state), H.concat(cur_buf_state), { result_type = "indices" })[1]
    logger.trace("Indices:", idx)
    if not idx then return end

    local old_lines = vim.list_slice(last_buf_state, idx[1], idx[1] + idx[2] - 1)
    local new_lines = vim.list_slice(cur_buf_state, idx[3], idx[3] + idx[4] - 1)

    local diff = {
      CONFLICT_START,
      H.concat(old_lines),
      CONFLICT_SEP,
      H.concat(new_lines),
      CONFLICT_END,
    }

    edit_history:add({ H.concat(diff), idx })
  end
end)

H.ternary = function(cond, T, F)
  if cond then
    return T
  else
    return F
  end
end

H.set_extmark = function(line, col, opts)
  return vim.api.nvim_buf_set_extmark(0, ns_id, line, col, opts)
end

H.del_extmark = function(id)
  return vim.api.nvim_buf_del_extmark(0, ns_id, id)
end

H.get_extmark = function(id, opts)
  return vim.api.nvim_buf_get_extmark_by_id(0, ns_id, id, opts or {})
end

H.get_lines = function(start, end_)
  start = start or 0
  end_ = end_ or -1
  return vim.api.nvim_buf_get_lines(0, start, end_, true)
end

H.concat = function(lines, i, j)
  return table.concat(lines, "\n", i, j)
end

H.insert = function(text)
  vim.api.nvim_put(vim.split(text, "\n", { plain = true }), "c", false, true)
end

H.escape = function(s)
  return string.gsub(s, "([%(%)%.%%%+%-*%?%[%^%$])", "%%%1")
end

H.trigger_event = function()
  vim.cmd.doautocmd("User StabStateChanged")
end

H.buf_call = function(bufnr, func)
  return vim.api.nvim_buf_call(bufnr, func)
end

H.buf_delete = function(bufnr, opts)
  return vim.api.nvim_buf_delete(bufnr, opts)
end

H.win_set_option = function(win_id, name, value)
  vim.api.nvim_set_option_value(name, value, { win = win_id })
end

H.buf_set_option = function(buf_id, name, value)
  vim.api.nvim_set_option_value(name, value, { buf = buf_id })
end

H.create_buf = function(listed, scratch)
  listed = H.ternary(listed, true, false)
  scratch = H.ternary(scratch, true, false)
  return vim.api.nvim_create_buf(false, true)
end

H.win_set_buf = function(window, buffer)
  return vim.api.nvim_win_set_buf(window or 0, buffer or 0)
end

H.buf_set_lines = function(buffer, start, end_, strict_indexing, replacement)
  return vim.api.nvim_buf_set_lines(buffer or 0, start or 0, end_ or -1, strict_indexing or false, replacement or {})
end

vim.api.nvim_create_augroup(group, { clear = true })
local au = function(event, pattern, callback)
  return vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback,
    group = group,
  })
end

H.trigger = function()
  -- if not H.is_ready() then return end
  local prompt, suffix = H.get_context()
  H.send_request(prompt, suffix)
end

---@param row integer
---@param col? integer
---@return boolean
H.cursor_on = function(row, col)
  logger.debug("Cursor on:", row, col)
  local pos = F.getpos(".")
  local cur_row = pos[2]
  local cur_col = pos[3]
  if row == cur_row and (col == nil or col == cur_col) then
    return true
  end
  return false
end

H.win_close = function(win_id, force)
  if vim.api.nvim_win_is_valid(win_id) then
    vim.api.nvim_win_close(win_id, force)
  end
end
local zeta_url = "http://127.0.0.1:7000/v1/completions"
-- local zeta_url = "http://192.168.2.31:1234/v1/completions"
local chat_url = "https://codestral.mistral.ai/v1/chat/completions"

vim.g.total_tokens = 0

H.presets = {}
H.presets.codestral = {
  -- url = "https://codestral.mistral.ai/v1/fim/completions",
  url = "https://api.mistral.ai/v1/fim/completions",
  headers = {
    content_type = "application/json",
    accept = "application/json",
    -- authorization = os.getenv("CODESTRAL_API_KEY"),
    authorization = "Bearer " .. os.getenv("MISTRAL_API_KEY"),
  },
  handle_prompt = function()
    local prefix, suffix = H.get_context()
    return {
      model = "codestral-latest",
      prompt = prefix,
      suffix = suffix,
      stop = { "\n>>", ">>>>" },
      max_tokens = 128,
    }
  end,
  handle_response = function(data)
    vim.g.total_tokens = vim.g.total_tokens + data.usage.total_tokens
    local input_cost = 0.2
    local output_cost = 0.6
    local cost = (data.usage.prompt_tokens * input_cost + data.usage.completion_tokens * output_cost) / 1000000
    logger.info("Session tokens: ", vim.g.total_tokens)
    logger.info("Session cost: $", string.format("%.6f", cost))
    return data.choices[1].message.content
  end
}
H.presets.gemini = {
  url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" ..
      os.getenv("GEMINI_API_KEY"),
  headers = {
    content_type = "application/json",
    accept = "application/json",
  },
  handle_prompt = function()
    local prefix, suffix = H.get_context()
    local prompt = prefix .. suffix
    return {
      contents = {
        {
          parts = {
            { text = prompt }
          }
        }
      }
    }
  end,
  handle_response = function(data)
    return data.candidates[1].content.parts[1].text
  end
}

H.clear = function()
  if S.suggestion.buf_id then
    logger.debug("Deleting buf:", S.suggestion.buf_id)
    H.buf_delete(S.suggestion.buf_id, { force = true })
    S.suggestion.buf_id = nil
  end
  if ext_ids and cache then
    -- logger.trace("Removing extmarks:", ext_ids)
    for _, id in ipairs(ext_ids) do
      H.del_extmark(id)
    end
    ext_ids = {}
    cache = {}
  end
end

H.calc_diff = function(content)
  if not content then return end

  S.suggestion.buf = vim.api.nvim_get_current_buf()
  local start = H.get_extmark(S.suggestion.ext_start)
  local end_ = H.get_extmark(S.suggestion.ext_end)

  local cursor_line = H.get_lines(start[1], end_[1] + 1)[1]
  local diff = dmp.diff_main(cursor_line, content)

  logger.trace("Cursorline:", cursor_line)

  if #diff == 1 and diff[1][1] == 0 then
    H.clear()
    return
  end

  S.suggestion.content = content
  dmp.diff_cleanupEfficiency(diff)
  logger.trace("Diff:", diff)

  return diff
end

H.display = function(content, diff)
  if F.mode() ~= "i" then return end
  H.clear()

  local additions = {}
  local deletions = {}

  local cur_line = S.suggestion.line - 1
  local cur_col = 0

  for i = 1, #diff do
    local width = #diff[i][2]
    local lines = vim.split(diff[i][2], "\n", { plain = false })
    logger.trace("Lines:", lines)
    if diff[i][1] == 0 then
      cur_line = cur_line + #lines - 1
      cur_col = cur_col + width
    elseif diff[i][1] == 1 then
      table.insert(additions, { lines[1], cur_line, cur_col })
    elseif diff[i][1] == -1 then
      table.insert(deletions, { lines[1], cur_line, cur_col })
    end
  end

  local is_change = #deletions > 0 and #additions > 0

  local col_offset = 0
  for _, deletion in ipairs(deletions) do
    logger.trace("Deletion:", deletion)
    local text, line, col = unpack(deletion)
    col = col + col_offset
    col_offset = col_offset + #text
    local ext_id = vim.api.nvim_buf_set_extmark(0, ns_id, line, col, {
      hl_group = "DiffDeleteBg",
      end_col = col + #text,
    })
    S.suggestion.loc = { line + 1, col + #text + 1 }
    table.insert(ext_ids, ext_id)
  end

  if is_change then
    local buf = H.create_buf()
    S.suggestion.buf_id = buf
    local bufpos = { S.suggestion.line, 0 }
    logger.debug("Creating buf:", buf, bufpos)
    local lines = vim.split(content, "\n")
    logger.debug("Buf lines:", lines)

    local width = vim.api.nvim_win_get_width(0)
    local win_width = F.strdisplaywidth(lines[1])
    local col, row = 0, -1
    if win_width < width / 2 then
      col = F.strdisplaywidth(vim.api.nvim_get_current_line()) + 4
      row = 0
    end

    H.open_win(buf, false, {
      relative = "win",
      col = col,
      row = row,
      bufpos = bufpos,
      width = win_width,
      -- height = #lines,
      height = 1,
      style = "minimal",
      anchor = "SW",
      border = "none",
    })
    H.buf_set_lines(buf, 0, -1, true, { lines[1] })
    H.buf_set_option(buf, "filetype", vim.bo.filetype)

    col_offset = 0
    for _, addition in ipairs(additions) do
      logger.trace("Addition:", addition)
      local text, line, col = unpack(addition)
      col = col + col_offset
      col_offset = col_offset + #text
      local ext_id = vim.api.nvim_buf_set_extmark(buf, ns_id, line - cur_line, col, {
        hl_group = "DiffAddBg",
        end_col = col + #text,
      })
      S.suggestion.loc = { line + 1, col + #text + 1 }
      table.insert(ext_ids, ext_id)
    end
    return
  end

  logger.debug("Setting extmarks")
  for _, addition in ipairs(additions) do
    local text, line, col = unpack(addition)
    local ext_id = H.set_extmark(line, col, {
      virt_text = { { text, "Comment" } },
      virt_text_pos = "inline",
    })
    S.suggestion.loc = { line + 1, col + #text + 1 }
    table.insert(ext_ids, ext_id)
  end
end

H.debounce = function(delay, fn)
  local timer = nil
  return function(...)
    local args = { ... }
    if timer then
      timer:stop()
      timer:close()
    end
    timer = vim.uv.new_timer()
    assert(timer, "Failed to create timer")
    timer:start(delay, 0, vim.schedule_wrap(function()
      fn(unpack(args))
    end))
  end
end

H.send_request = function(prompt, suffix)
  vim.b.stabbing = true
  H.trigger_event()
  cache.dirty = true

  S.suggestion.ext_start = H.set_extmark(S.suggestion.line - 1, 0, {
    id = S.suggestion.ext_start or 99,
    right_gravity = false,
  })
  S.suggestion.ext_end = H.set_extmark(S.suggestion.line - 1, #vim.api.nvim_get_current_line(), {
    id = S.suggestion.ext_end or 100,
  })
  local id = H.set_extmark(S.suggestion.line - 1, 0, {
    end_row = S.suggestion.line - 1,
    end_col = #vim.api.nvim_get_current_line(),
    -- hl_group = "Underlined",
  })
  table.insert(ext_ids, id)

  logger.debug("Creating start:", S.suggestion.ext_start)
  logger.debug("Creating end:", S.suggestion.ext_end)

  H.request(prompt, H.presets.codestral, function(content)
    logger.debug("Content:", content)
    local lines = vim.split(content, "\n", { plain = true, trimempty = true })
    logger.debug("Lines:", lines)
    content = lines[1]

    cache.output = content
    cache.display = content
    local diff = H.calc_diff(content)
    if not diff then
      logger.debug("No diff found")
      return
    end
    S.suggestion.diff = diff
    H.display(content, diff)
  end)
end

H.open_win = function(bufnr, enter, opts)
  opts = opts or {}
  opts.row = opts.row and opts.row or nil
  opts.col = opts.col and opts.col or nil
  return vim.api.nvim_open_win(bufnr, enter, opts)
end

H.request = function(prompt, provider, callback)
  logger.debug("Sending request...", prompt, provider)
  provider = provider or {}

  curl.request({
    method = "post",
    url = provider.url,
    headers = provider.headers,
    body = vim.json.encode(provider.handle_prompt(prompt)),
    callback = function(response)
      logger.debug("Response:", response)
      vim.schedule(function()
        vim.b.stabbing = false
        H.trigger_event()
      end)

      if response.status ~= 200 then
        logger.error(response.status, response.body)
        return
      end

      local ok, data = pcall(vim.json.decode, response.body)
      if not ok then
        vim.notify("Failed to parse response", vim.log.levels.ERROR)
        return
      end

      if data.error then
        vim.notify("API Error: " .. data.error.message, vim.log.levels.ERROR)
        return
      end

      vim.schedule_wrap(callback)(provider.handle_response(data))
    end,
  })
end

H.comment = function(text)
  return vim.bo.commentstring:format(text) .. "\n"
end

H.get_context = function(max_lines)
  max_lines = max_lines or 30
  local max_editable = 0
  local all_lines = H.get_lines(0, -1)
  local pos = F.getpos(".")
  local row, col = pos[2], pos[3]
  S.suggestion.line = row - max_editable

  for _, edit in ipairs(edit_history:get_all()) do
    local text, idx = edit[1], edit[2]
    all_lines[idx[1]] = text
    for i = idx[3] + 1, idx[3] + idx[4] - 1 do
      all_lines[i] = ""
    end
  end

  local lines_before = vim.list_slice(all_lines, row - max_lines, row - max_editable - 1)
  local lines_after = vim.list_slice(all_lines, row + max_editable + 1, row + max_lines)
  local lines_editable = vim.list_slice(all_lines, row - max_editable, row + max_editable)

  S.suggestion.prompt = H.concat(lines_editable)

  local prefix = {
    H.concat(lines_before),
    "<<<<<<< HEAD",
    H.concat(lines_editable),
    "=======\n",
  }

  local suffix = {
    "\n>>>>>>>",
    H.concat(lines_after),
  }

  return H.concat(prefix), H.concat(suffix)
end

local exclude_filetypes = {
  "markdown",
}

H.is_ready = function()
  if vim.tbl_contains(exclude_filetypes, vim.bo.filetype) then return false end
  if vim.bo.buftype ~= "" then return false end
  if vim.bo.filetype == "" then return false end
  if F.mode() ~= "i" then return false end
  if F.pumvisible() == 1 then return false end
  if F.reg_recording() ~= "" then return false end
  if require("blink-cmp").is_menu_visible() then return false end
  if cache.output or cache.dirty then return false end
  return true
end

H.debounced_complete = nil

M.setup = function(opts)
  opts = opts or {}
  opts.debounce = opts.debounce or 200

  dmp.settings({
    Match_Threshold = 0.1,
    Match_Distance = 1000,
  })

  local hl = vim.api.nvim_get_hl(0, { name = "DiffDelete" })
  vim.api.nvim_set_hl(0, "DiffDeleteBg", { bg = hl.bg })

  hl = vim.api.nvim_get_hl(0, { name = "DiffAdd" })
  vim.api.nvim_set_hl(0, "DiffAddBg", { bg = hl.bg })

  local trigger_debounced = H.debounce(opts.debounce, H.trigger)

  au({ "InsertLeave" }, "*", function()
    H.clear()
    S.suggestion.content = nil
  end)
  au("InsertEnter", "*", H.trigger)

  au("TextChangedI", "*", function()
    -- if S.suggestion.ext_start and not H.cursor_on(H.get_extmark(S.suggestion.ext_start)[1] + 1) then return end
    if not H.is_ready() then return end
    if not S.suggestion.diff then return end

    if S.suggestion.content then
      S.suggestion.diff = H.calc_diff(S.suggestion.content)
      if not S.suggestion.diff then return end
      H.display(S.suggestion.content, S.suggestion.diff)
    end

    local pattern = vim.iter(S.suggestion.diff):filter(function(item)
      if item[1] == -1 then
        return false
      end
      return item
    end):map(function(item)
      return item[2]
    end):join("")

    local query = {
      pattern = string.sub(vim.api.nvim_get_current_line(), 1, 32),
      text = pattern,
      loc = 0,
    }

    logger.debug("Matching:", query)
    local bitap = dmp.match_bitap(query.text, query.pattern, query.loc)

    if bitap == -1 then
      trigger_debounced()
      logger.debug("No match found")
    end
  end)

  logger.info("\n")
  logger.info("Initialized")
end

M.complete = function()
  if ext_ids and S.suggestion.content and not S.suggestion.available then
    logger.trace(S.suggestion)
    local ext_start = H.get_extmark(S.suggestion.ext_start)
    local ext_end = H.get_extmark(S.suggestion.ext_end)
    local range = {
      ["start"] = { line = ext_start[1], character = ext_start[2] },
      ["end"] = { line = ext_end[1], character = ext_end[2] },
    }
    vim.lsp.util.apply_text_edits({ {
      range = range,
      newText = S.suggestion.content,
    } }, S.suggestion.buf, "utf-8")
    -- H.buf_set_lines(0, F.line(".") - 1, F.line("."), true, vim.split(S.suggestion.content, "\n", { plain = true }))
    H.clear()
    F.cursor(S.suggestion.loc)
  end
end

return M
