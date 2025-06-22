local dmp                  = require("util.diff")
local group                = "Stab"
local curl                 = require("plenary.curl")
local logger               = require("util.logger")
local F                    = vim.fn

local ns_id                = vim.api.nvim_create_namespace("Stab")
local ext_ids              = {}
local cache                = {}

local H                    = {}
local M                    = {}
local S                    = {
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

local HL_GROUP = "NonText"

H.debounce                 = function(delay, fn)
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

local CONFLICT_START       = "<<<<<<<< HEAD"
local CONFLICT_SEP         = "========"
local CONFLICT_END         = ">>>>>>>>"

local cbuf                 = require("util.cbuf")
local last_buf_state       = nil
local edit_history         = cbuf:new(3)

H.debounced_update_history = H.debounce(1000, function(cur_buf_state)
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
    CONFLICT_END .. "\n",
  }

  -- edit_history:add({ H.concat(diff), idx })
  edit_history:add(vim.diff(H.concat(last_buf_state), H.concat(cur_buf_state)) .. "\n")
  last_buf_state = nil
end)

au({ "TextChanged", "TextChangedI" }, "*", function(ev)
  local cur_buf_state = H.get_lines()
  if not last_buf_state then
    last_buf_state = cur_buf_state
  end

  H.debounced_update_history(cur_buf_state)
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
  return vim.api.nvim_buf_get_lines(0, start, end_, false)
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
  -- local prompt, suffix = H.get_context()
  H.send_request()
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
  handle_prompt = function(prefix, suffix)
    return {
      model = "codestral-latest",
      prompt = prefix,
      suffix = suffix,
      temperature = 0.1,
      stop = { "\n>>", ">>>>", "\n\n" },
      max_tokens = 196,
    }
  end,
  handle_response = function(data)
    vim.g.total_tokens = vim.g.total_tokens + data.usage.total_tokens
    local input_cost = 0.2
    local output_cost = 0.6
    local cost = (data.usage.prompt_tokens * input_cost + data.usage.completion_tokens * output_cost) / 1000000
    logger.info("Session tokens: ", vim.g.total_tokens)
    logger.info("Session cost: $", string.format("%.6f", cost))

    return data.choices[1].message.content:gsub("█", "")
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

  logger.trace("Start:", start)
  logger.trace("End:", end_)

  local original = H.get_lines(start[1], end_[1] + 1)
  logger.trace("Original:", original)
  local diff = dmp.diff_main(H.concat(original), content)

  if #diff == 1 and diff[1][1] == 0 then
    H.clear()
    return
  end

  S.suggestion.content = content
  dmp.diff_cleanupEfficiency(diff)
  logger.trace("Diff:", diff)

  return diff
end

function H.count(base, pattern)
  return select(2, string.gsub(base, pattern, ""))
end

H.display = function(content, diffs)
  if F.mode() ~= "i" then return end
  H.clear()

  local content_lines = vim.split(content, "\n")

  local n_deletions = 0
  local n_insertions = 0
  vim.iter(diffs):each(function(item)
    logger.trace("Item:", item)
    if item[1] == -1 then
      n_deletions = n_deletions + 1
    elseif item[1] == 1 then
      n_insertions = n_insertions + 1
    end
  end)
  logger.trace("n_deletions", n_deletions)
  logger.trace("n_insertions", n_insertions)

  local insertions_only = n_deletions == 0 and n_insertions > 0
  local show_popup      = n_deletions > 0 and n_insertions > 0

  if insertions_only then
    local cursor = { S.suggestion.line - 1, 0 }

    vim.iter(diffs):each(function(diff)
      logger.trace("Diff:", diff)
      local lines = vim.split(diff[2], "\n", { plain = true })
      if diff[1] == 0 then
        cursor[1] = cursor[1] + H.count(diff[2], "\n")
        for _, line in ipairs(lines) do
          cursor[2] = cursor[2] + #line
        end
      elseif diff[1] == 1 then
        local virt_lines = vim.iter(lines):slice(2, #lines):map(function(line)
          return { { line, HL_GROUP } }
        end):totable()

        logger.trace("virt_lines:", virt_lines)

        local ext_id = vim.api.nvim_buf_set_extmark(0, ns_id, cursor[1], cursor[2], {
          virt_text     = { { lines[1], HL_GROUP } },
          virt_lines    = virt_lines,
          virt_text_pos = "inline",
        })
        table.insert(ext_ids, ext_id)
      end
    end)
    return
  end

  local cursor = { S.suggestion.line - 1, 0 }
  vim.iter(diffs):each(function(diff)
    -- advance cursor by this diff, placing a delete‐highlight extmark on deletions
    local kind, text = diff[1], diff[2]
    local start_row, start_col = cursor[1], cursor[2]

    -- walk all the lines in text to update cursor
    local nl_count = H.count(text, "\n")
    if nl_count > 0 then
      -- if text contains newlines, the last line's length is the new column
      local parts = vim.split(text, "\n", { plain = true })
      cursor[1] = cursor[1] + nl_count
      cursor[2] = #parts[#parts]
    else
      -- single‐line chunk: just advance by the length
      cursor[2] = cursor[2] + #text
    end

    if kind == -1 then
      -- for deletions, mark from the start to the updated cursor
      local ext_id = vim.api.nvim_buf_set_extmark(0, ns_id, start_row, start_col, {
        hl_group = "DiffDeleteBg",
        end_row  = cursor[1],
        end_col  = cursor[2],
        strict   = false,
      })
      table.insert(ext_ids, ext_id)
    end
  end)
  S.suggestion.loc = { cursor[1], cursor[2] }

  if show_popup then
    local buf = vim.api.nvim_create_buf(true, true)
    S.suggestion.buf_id = buf
    H.buf_set_option(buf, "filetype", vim.bo.filetype)
    vim.api.nvim_open_win(buf, false, {
      relative = "win",
      col      = #vim.api.nvim_get_current_line() + 4,
      row      = -1,
      bufpos   = { S.suggestion.line, 0 },
      width    = 40,
      height   = #content_lines,
      style    = "minimal",
      anchor   = "NW",
      border   = "none",
    })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))

    cursor = { 0, 0 }
    vim.iter(diffs):each(function(diff)
      -- advance cursor by this diff, placing a delete‐highlight extmark on deletions
      local kind, text = diff[1], diff[2]
      local start_row, start_col = cursor[1], cursor[2]

      -- walk all the lines in text to update cursor
      local nl_count = H.count(text, "\n")
      if nl_count > 0 then
        -- if text contains newlines, the last line's length is the new column
        local parts = vim.split(text, "\n", { plain = true })
        cursor[1] = cursor[1] + nl_count
        cursor[2] = #parts[#parts]
      else
        -- single‐line chunk: just advance by the length
        cursor[2] = cursor[2] + #text
      end

      if kind == 1 then
        -- for deletions, mark from the start to the updated cursor
        local ext_id = vim.api.nvim_buf_set_extmark(buf, ns_id, start_row, start_col, {
          hl_group = "DiffAddBg",
          end_row  = cursor[1],
          end_col  = cursor[2],
          strict   = false,
        })
        table.insert(ext_ids, ext_id)
      end
    end)
  end
end

H.send_request = function(prompt, suffix)
  vim.b.stabbing = true
  H.trigger_event()
  cache.dirty = true

  H.request(prompt, H.presets.codestral, function(content)
    logger.debug("Content:", content)
    content = F.trim(content, "\n")
    local diff = H.calc_diff(content)
    logger.debug("Diff:", diff)
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
  local prefix, suffix = H.get_context()

  curl.request({
    method = "post",
    url = provider.url,
    headers = provider.headers,
    body = vim.json.encode(provider.handle_prompt(prefix, suffix)),
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
  return vim.bo.commentstring:format(text)
end

math.clamp = function(value, min, max)
  return math.min(math.max(value, min), max)
end

H.get_context = function(max_lines)
  max_lines = max_lines or 4
  local max_editable = 0
  local all_lines = H.get_lines()
  local pos = F.getpos(".")
  local row, col = pos[2], pos[3]
  S.suggestion.line = row

  local edit_range = {
    start = {
      row = math.clamp(row, 0, #all_lines),
      col = 0,
    },
    end_ = {
      row = math.clamp(row + max_editable, 0, #all_lines),
      col = 0,
    }
  }

  edit_range.end_.col = #all_lines[edit_range.end_.row]

  logger.trace("edit_range", edit_range)

  S.suggestion.ext_start = H.set_extmark(edit_range.start.row - 1, edit_range.start.col, {
    id = S.suggestion.ext_start or 99,
    right_gravity = false,
  })
  S.suggestion.ext_end = H.set_extmark(edit_range.end_.row - 1, edit_range.end_.col, {
    id = S.suggestion.ext_end or 100,
  })
  local id = H.set_extmark(edit_range.start.row - 1, edit_range.start.col, {
    end_row = edit_range.end_.row - 1,
    end_col = edit_range.end_.col,
    -- hl_group = "Visual",
  })
  table.insert(ext_ids, id)

  local lines_before = vim.list_slice(all_lines, row - max_lines, edit_range.start.row - 1)
  local lines_editable = vim.list_slice(all_lines, edit_range.start.row, edit_range.end_.row)
  local lines_after = vim.list_slice(all_lines, edit_range.end_.row + 1, row + max_lines)

  S.suggestion.prompt = H.concat(lines_editable)

  local cursor_line = string.sub(vim.api.nvim_get_current_line(), 1, F.col(".") - 1) ..
      "█" .. string.sub(vim.api.nvim_get_current_line(), F.col("."))

  -- logger.debug("ts_context: ", ts_context)
  local prefix = {
    -- H.concat(edit_history:get_all()),
    H.concat(lines_before),
    CONFLICT_START,
    cursor_line,
    -- H.concat(lines_editable, 2),
    CONFLICT_SEP .. "\n",
  }
  local suffix = {
    "\n" .. CONFLICT_END,
    H.concat(lines_after),
  }

  logger.trace(H.concat(prefix), H.concat(suffix))

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
  if cache.dirty then return false end
  return true
end

H.debounced_complete = nil

M.setup = function(opts)
  opts = opts or {}
  opts.debounce = opts.debounce or 200

  dmp.settings({
    Match_Threshold = 0.20,
    Match_Distance = 100,
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
      H.clear()
      S.suggestion.content = nil
      trigger_debounced()
    end
  end)

  logger.info("\n")
  logger.info("Initialized")
end

S.next_edit = false
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
    -- M.try_next()
    -- F.cursor(S.suggestion.loc)
  end
end

M.try_next = function()
  dmp.settings({
    Match_Threshold = 0.8,
    Match_Distance = 1000,
  })

  if ext_ids and S.suggestion.content and not S.suggestion.available then
    local lines = H.concat(H.get_lines(F.line(".")))
    local diffs = vim.iter(S.suggestion.diff):filter(function(diff)
      if diff[1] == 1 then
        return false
      end
      return diff
    end):map(function(diff)
      return diff[2]
    end):join("")

    logger.debug("Matching:", lines, "vs", diffs)
    local idx = dmp.match_bitap(lines, string.sub(diffs, 1, 10), 0)
    if idx == -1 then
      return
    end

    logger.debug("Match index:", idx)
    local match = string.sub(lines, idx, idx + 10)
    local pos = F.searchpos(match, "W")
    S.pos = pos
    logger.debug("Match:", match)
    logger.debug("Match in:", pos)
    local ext_id = vim.api.nvim_buf_set_extmark(0, ns_id, pos[1] - 1, 0, {
      virt_text = { { " TAB ", "LspInlayHint" } },
      virt_text_pos = "eol",
      -- virt_text_win_col = 100,
    })
    S.next_edit = true
  end
end

function M.jump()
  F.cursor(S.pos[1], 0)
  H.trigger()
  S.next_edit = false
end

return M
