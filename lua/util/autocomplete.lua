local group = "Stab"
local curl = require("plenary.curl")

local ns_id = vim.api.nvim_create_namespace("Stab")
local ext_id
local cache = {}

local H = {}
local M = {}
H.state = {
  retries = 0,
  max_retries = 3,
}

H.set_extmark = function(line, col, opts) return vim.api.nvim_buf_set_extmark(0, ns_id, line, col, opts) end
H.del_extmark = function(id) return vim.api.nvim_buf_del_extmark(0, ns_id, id) end
H.get_extmark = function(id, opts) return vim.api.nvim_buf_get_extmark_by_id(0, ns_id, id, opts) end
H.get_lines = function(start, end_) return vim.api.nvim_buf_get_lines(0, start, end_, true) end
H.concat = function(lines, i, j) return table.concat(lines, "\n", i, j) end
H.insert = function(text) vim.api.nvim_put(vim.split(text, "\n", { plain = true }), "c", false, true) end
H.escape = function(s) return string.gsub(s, "([%(%)%.%%%+%-*%?%[%^%$])", "%%%1") end
H.debug = function(msg)
  vim.notify(vim.inspect(msg), vim.log.levels.DEBUG)
end
H.error = function(msg)
  vim.notify(vim.inspect(msg), vim.log.levels.ERROR)
end
H.trigger_event = function()
  vim.cmd.doautocmd("User StabStateChanged")
end

vim.api.nvim_create_augroup(group, { clear = true })
local au = function(event, pattern, callback)
  return vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback,
    group = group,
  })
end

local url = "https://codestral.mistral.ai/v1/fim/completions"
local headers = {
  content_type = "application/json",
  accept = "application/json",
  authorization = os.getenv("CODESTRAL_API_KEY"),
}

H.clear = function()
  if ext_id and cache then
    H.del_extmark(ext_id)
    cache = {}
  end
end

H.display = function(content)
  if vim.fn.mode() ~= "i" then return end

  local lines = vim.split(content, "\n", { plain = true })
  local virt_lines = {}
  local virt_text = { { lines[1], "Comment" } }
  if #lines > 1 then
    for i = 2, #lines do
      table.insert(virt_lines, { { lines[i], "Comment" } })
    end
  end

  ext_id = H.set_extmark(vim.fn.line(".") - 1, vim.fn.col(".") - 1, {
    id = ext_id,
    virt_text = virt_text,
    virt_lines = virt_lines,
    virt_text_pos = "inline",
    virt_text_repeat_linebreak = false,
  })
end

H.on_text = function()
  if not cache.display then
    H.clear()
    return
  end
  local line = vim.api.nvim_get_current_line()
  local _prompt = vim.split(cache.prompt, "\n", { plain = true })
  local prompt = _prompt[#_prompt]

  local delta = string.gsub(line, H.escape(prompt), "")

  local display, count = string.gsub(cache.output, "^" .. H.escape(delta), "")
  cache.display = display

  if count > 0 then
    H.display(cache.display)
  else
    H.clear()
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
  curl.request({
    method = "post",
    url = url,
    headers = headers,
    body = vim.json.encode({
      model = "codestral-latest",
      prompt = prompt,
      suffix = suffix,
      stop = { "\n\n" },
      max_tokens = 256,
      temperature = 0,
    }),
    callback = function(response)
      if response.status ~= 200 then
        -- vim.notify("API Error (Status " .. response.status .. ")", vim.log.levels.ERROR)
        H.state.retries = H.state.retries + 1
        if H.state.retries < H.state.max_retries then
          H.debounced_complete()
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

      vim.schedule(function()
        local content = data.choices[1].message.content
        cache.prompt = prompt
        cache.output = content
        cache.display = content
        H.display(content)

        vim.b.stabbing = false
        H.trigger_event()
      end)
    end,
  })
end

H.get_context = function(max_lines)
  max_lines = max_lines or 100
  local all_lines = H.get_lines(0, -1)
  local pos = vim.fn.getpos(".")
  local row, col = pos[2], pos[3]

  local cursorline = all_lines[row]
  local before_cursor = string.sub(cursorline, 1, col - 1)
  local after_cursor = string.sub(cursorline, col)

  local truncate_lines = function(lines, max_count)
    if #lines <= max_count then return lines end
    local half = math.floor(max_count / 2)
    local start_chunk = vim.list_slice(lines, 1, half)
    start_chunk[#start_chunk] = start_chunk[#start_chunk] .. "\n\n" .. vim.bo.commentstring:format("truncated...") .. "\n"
    local end_chunk = vim.list_slice(lines, #lines - half + 1, #lines)
    return vim.list_extend(start_chunk, end_chunk)
  end

  local lines_before = vim.list_slice(all_lines, 1, row - 1)
  local lines_after = vim.list_slice(all_lines, row + 1)
  local lines_before_truncated = truncate_lines(lines_before, max_lines)
  local lines_after_truncated = truncate_lines(lines_after, max_lines)

  local prompt = H.concat(lines_before_truncated) .. "\n" .. before_cursor
  local suffix = after_cursor .. "\n" .. H.concat(lines_after_truncated)
  return prompt, suffix
end

H.trigger = function()
  if vim.fn.mode() ~= "i" then return end
  local prompt, suffix = H.get_context()
  -- vim.print(prompt .. "X" .. suffix)
  H.send_request(prompt, suffix)
end

H.is_ready = function()
  if vim.bo.buftype ~= "" then return false end
  if vim.bo.filetype == "" then return false end
  if vim.fn.mode() ~= "i" then return false end
  if vim.fn.pumvisible() == 1 then return false end
  if vim.fn.reg_recording() ~= "" then return false end
  if cache.output or cache.dirty then return false end
  return true
end

H.debounced_complete = nil

M.setup = function(opts)
  opts = opts or {}
  opts.debounce = opts.debounce or 400

  H.debounced_complete = H.debounce(opts.debounce, H.trigger)
  au("InsertLeave", "*", H.clear)
  au("TextChangedI", "*", H.on_text)
  au({ "TextChangedI", "InsertEnter" }, "*", function()
    if H.is_ready() then
      H.debounced_complete()
    end
  end)
end

M.complete = function()
  if ext_id and cache.display then
    H.insert(cache.display)
    H.clear()
  end
end

return M
