local group = "Patrick"

local F = vim.fn
local state = {
  query = nil,
  backward = false,
  match_id = nil,
  au_id = nil,
  ve = vim.o.ve,
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

local format_query = function(query, backward, till, operator)
  query = [[\V]] .. F.escape(query, [[\]])

  if till and not operator and not backward then
    return [[\_.\ze]] .. query
  end

  if (till and backward) or (not till and operator and not backward) then
    return query .. [[\zs\_.]]
  end

  return query
end

local jump_fn = function(backward, n, till, operator)
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

    local query = format_query(table.concat(chars), backward, till, operator)

    vim.wo.ve = "onemore"
    F.search(query, flags)
    vim.wo.ve = state.ve

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
---@param operator boolean
---@param till boolean
local jump = function(backward, n, operator, till)
  for _ = 1, vim.v.count1 do
    jump_fn(backward, n, operator, till)
  end
end

return { jump = jump }
