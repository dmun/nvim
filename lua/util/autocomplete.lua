local dmp = require("util.diff")
local group = "Stab"
local curl = require("plenary.curl")
local F = vim.fn

local ns_id = vim.api.nvim_create_namespace("Stab")
local fim_ext_id
local ext_ids = {}
local cache = {}

local H = {}
local M = {}
local S = {
  retries = 0,
  max_retries = 3,
  next_edit = {
    range = {},
    content = nil,
    available = false,
    ext_id = nil,
    line = 1,
    buf_id = nil,
    diff = nil,
  }
}

local cbuf = require("util.cbuf")
local last_buf_state = ""
local last_diffs = cbuf:new(4)

au("ModeChanged", "*", function(ev)
  local old, new = unpack(vim.split(ev.match, ":"))
  local cur_buf_state = table.concat(H.get_lines(), "\n")

  if old == "n" then
    last_buf_state = cur_buf_state
  elseif new == "n" then
    last_diffs:add(vim.diff(last_buf_state, cur_buf_state))
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
  return vim.api.nvim_buf_get_extmark_by_id(0, ns_id, id, opts)
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

H.debug = function(msg)
  vim.notify(vim.inspect(msg), vim.log.levels.DEBUG)
end

H.error = function(msg)
  vim.notify(vim.inspect(msg), vim.log.levels.ERROR)
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

local zeta_url = "http://127.0.0.1:7000/v1/completions"
-- local zeta_url = "http://192.168.2.31:1234/v1/completions"
local chat_url = "https://codestral.mistral.ai/v1/chat/completions"

H.presets = {}
H.presets.codestral = {
  url = "https://codestral.mistral.ai/v1/fim/completions",
  headers = {
    content_type = "application/json",
    accept = "application/json",
    authorization = os.getenv("CODESTRAL_API_KEY"),
  },
  handle_prompt = function()
    local prefix, suffix = H.get_context()
    return {
      model = "codestral-latest",
      prompt = prefix,
      suffix = suffix,
      stop = { "\n>>" },
      max_tokens = 256,
    }
  end,
  handle_response = function(data)
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
  if ext_ids and cache then
    for _, id in ipairs(ext_ids) do
      H.del_extmark(id)
    end
    if S.next_edit.buf_id then
      H.buf_delete(S.next_edit.buf_id, { force = true })
      S.next_edit.buf_id = nil
    end
    cache = {}
  end
end

H.display = function(content)
  if F.mode() ~= "i" then return end

  local diff = dmp.diff_main(S.next_edit.prompt, content)
  if #diff == 1 and diff[1][1] == 0 then
    H.clear()
    return
  end

  S.next_edit.content = content
  dmp.diff_cleanupEfficiency(diff)

  local additions = {}
  local deletions = {}

  local cur_line = S.next_edit.line - 1
  local cur_col = 0

  for i = 1, #diff do
    local lines = vim.split(diff[i][2], "\n", { plain = true })
    if diff[i][1] == 0 then
      cur_line = cur_line + #lines - 1
      cur_col = #lines[#lines]
    elseif diff[i][1] == 1 then
      table.insert(additions, { lines[1], cur_line, cur_col })
    elseif diff[i][1] == -1 then
      table.insert(deletions, { lines[1], cur_line, cur_col })
    end
  end

  local is_change = #deletions > 0

  for _, deletion in ipairs(deletions) do
    local text, line, col = unpack(deletion)
    local ext_id = H.set_extmark(line, col, {
      virt_text = { { text, "DiffDelete" } },
      virt_text_pos = "overlay",
    })
    table.insert(ext_ids, ext_id)
  end

  if is_change then
    local buf = H.create_buf()
    S.next_edit.buf_id = buf
    local lines = vim.split(content, "\n")
    H.open_win(buf, false, {
      relative = "win",
      col = #S.next_edit.prompt + 5,
      row = F.line(".") - 2,
      width = #content,
      height = #lines,
      style = "minimal",
      anchor = "NW",
      border = "none",
    })
    H.buf_set_lines(buf, 0, -1, true, lines)
    H.buf_set_option(buf, "filetype", vim.bo.filetype)

    for _, addition in ipairs(additions) do
      local text, line, col = unpack(addition)
      local ext_id = vim.api.nvim_buf_set_extmark(buf, ns_id, line - cur_line, col, {
        virt_text = { { text, "DiffAdd" } },
        virt_text_pos = "overlay",
      })
      S.next_edit.loc = { line + 1, col + #text + 1 }
      table.insert(ext_ids, ext_id)
    end
    return
  end

  for _, addition in ipairs(additions) do
    local text, line, col = unpack(addition)
    local ext_id = H.set_extmark(line, col, {
      virt_text = { { text, "Comment" } },
      virt_text_pos = "inline",
      virt_text_repeat_linebreak = false,
    })
    S.next_edit.loc = { line + 1, col + #text + 1 }
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
  H.request(prompt, H.presets.codestral, function(content)
    cache.output = content
    cache.display = content
    H.display(content)
  end)
end

H.open_win = function(bufnr, enter, opts)
  opts = opts or {}
  opts.row = opts.row and opts.row + 1 or nil
  opts.col = opts.col and opts.col + 1 or nil
  return vim.api.nvim_open_win(bufnr, enter, opts)
end

H.request = function(prompt, provider, callback)
  provider = provider or {}

  curl.request({
    method = "post",
    url = provider.url,
    headers = provider.headers,
    body = vim.json.encode(provider.handle_prompt(prompt)),
    callback = function(response)
      vim.schedule(function()
        vim.b.stabbing = false
        H.trigger_event()
      end)

      if response.status ~= 200 then
        -- vim.notify("API Error (Status " .. response.status .. ")", vim.log.levels.ERROR)
        S.retries = S.retries + 1
        if S.retries < S.max_retries then
          -- H.debounced_complete()
        end
        H.error("Stab: Max retries reached")
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
  max_lines = max_lines or 100
  local max_editable = 0
  local all_lines = H.get_lines(0, -1)
  local pos = F.getpos(".")
  local row, col = pos[2], pos[3]
  S.next_edit.line = row - max_editable

  local lines_before = vim.list_slice(all_lines, row - max_lines, row - max_editable - 1)
  local lines_after = vim.list_slice(all_lines, row + max_editable + 1, row + max_lines)
  local lines_editable = vim.list_slice(all_lines, row - max_editable, row + max_editable)

  S.next_edit.prompt = H.concat(lines_editable)

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

H.trigger = function()
  if vim.fn.mode() ~= "i" then return end
  local prompt, suffix = H.get_context()
  -- vim.print(prompt .. "X" .. suffix)
  H.send_request(prompt, suffix)
end

---@param row integer
---@param col? integer
---@return boolean
H.cursor_on = function(row, col)
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
  opts.debounce = opts.debounce or 400

  H.debounced_complete = H.debounce(opts.debounce, H.trigger)
  au("InsertLeave", "*", H.clear)
  au({ "TextChangedI", "InsertEnter" }, "*", function()
    -- H.trigger_edit()
    if H.is_ready() then
      H.debounced_complete()
    end
  end)
end

H.safe_diff_apply = function(diff)
  local command = string.format("echo '%s' | patch -u -l -s -N -F 5 -o -", diff)
  vim.system({ vim.o.shell, vim.o.shellcmdflag, command }, {}, function(obj)
    if obj.code ~= 0 then
      vim.notify("Failed to apply patch, was it already applied?", vim.log.levels.ERROR)
      vim.print(obj.stderr)
      vim.print(obj.stdout)
      return
    end

    vim.schedule(function()
      local original_buf = vim.api.nvim_get_current_buf()
      local patch_buf = H.create_buf(false, true)

      H.buf_set_lines(patch_buf, 0, -1, false, vim.split(obj.stdout, "\n"))
      H.buf_call(original_buf, vim.cmd.diffthis)
      H.buf_call(patch_buf, vim.cmd.diffthis)

      vim.cmd("%diffget")
      vim.cmd("diffoff!")
      H.buf_delete(patch_buf, { force = true })
    end)
  end)
end

M.complete = function()
  if ext_ids and S.next_edit.content and not S.next_edit.available then
    H.buf_set_lines(0, F.line(".") - 1, F.line("."), true, vim.split(S.next_edit.content, "\n", { plain = true }))
    F.cursor(S.next_edit.loc)
    H.clear()
  end
end

return M
