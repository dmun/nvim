local group = "Patrick"

local F = vim.fn
local state = {
  query = nil,
  backward = false,
  match_id = nil,
  au_id = nil,
  eiw = vim.o.eiw,
}

vim.api.nvim_create_augroup(group, { clear = true })
local au = function(event, pattern, callback)
  vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback,
    group = group,
  })
end

local format_query = function(query, backward, till)
  query = [[\V]] .. F.escape(query, [[\]])

  if till and not backward then
    return [[\_.\ze]] .. query
  elseif till then
    return query .. [[\zs\_.]]
  end

  return query
end

local jump = function(backward, n, till)
  local flags = (state.backward ~= backward) and "Wb" or "W"
  if not state.query then
    state.backward = backward
  end
  n = n or 2

  if state.query then
    vim.wo.eiw = state.eiw .. "CursorMoved"
    F.search(state.query, flags)
    vim.schedule(function() vim.wo.eiw = state.eiw end)
  else
    local chars = {}

    for i = 1, n do
      local char = F.getcharstr()
      if char == "" then return end
      chars[i] = char
    end

    local query = format_query(table.concat(chars), backward, till)
    F.search(query, flags)

    local ok, match_id = pcall(F.matchadd, group, query, -1, state.match_id or -1)
    if ok then state.match_id = match_id end

    vim.schedule(function()
      if state.au_id then return end
      state.query = query
      state.au_id = au({ "CursorMoved", "CursorMovedI", "ModeChanged" }, "*", function(ev)
        pcall(F.matchdelete, match_id)
        vim.api.nvim_del_autocmd(ev.id)
        state.query = nil
        state.au_id = nil
        state.backward = false
        state.match_id = nil
      end)
    end)
  end
end

---@param backward boolean
---@param n number
---@param till? boolean
local operatorfunc = function(backward, n, till)
  return function()
    return string.format("v<Cmd>lua require'util.jump'.jump(%s, %d, %s)<CR>", backward, n, till, false)
  end
end

return { jump = jump, operatorfunc = operatorfunc }
