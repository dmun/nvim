Patrick = {}

local group = "Patrick"
local F = vim.fn

Patrick.state = {
  pattern = nil,
  backward = false,
  match_id = nil,
  au_id = nil,
  eiw = vim.o.eiw,
  active = false,
  n_moves = 0,
}

vim.api.nvim_create_augroup(group, { clear = true })
local au = function(event, pattern, callback)
  return vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback,
    group = group,
  })
end

local format_query = function(query, backward, till)
  local prefix = [[\V]]
  local suffix = ""

  if till and not backward then
    prefix = prefix .. [[\_.\ze]]
  elseif till then
    suffix = suffix .. [[\zs\_.]]
  end

  if vim.o.ignorecase and vim.o.smartcase and string.match(query, "%u") then
    suffix = suffix .. [[\C]]
  elseif vim.o.ignorecase then
    suffix = suffix .. [[\c]]
  end

  return prefix .. F.escape(query, [[\]]) .. suffix
end

Patrick.get_query = function(n)
  local chars = {}

  for i = 1, n do
    local char = F.getcharstr()
    if char == "" then return end
    chars[i] = char
  end

  return table.concat(chars)
end


Patrick.watch_stop = function()
  if Patrick.state.au_id then return end
  Patrick.state.au_id = au({ "CursorMoved", "CursorMovedI" }, "*", function(ev)
    Patrick.state.n_moves = Patrick.state.n_moves + 1
    if Patrick.state.n_moves < 2 then return end
    pcall(F.matchdelete, Patrick.state.match_id)
    vim.api.nvim_del_autocmd(ev.id)
    Patrick.state.active = false
    Patrick.state.au_id = nil
    Patrick.state.match_id = nil
  end)
end

Patrick.highlight = function()
  local ok, match_id = pcall(F.matchadd, group, Patrick.state.pattern, -1, Patrick.state.match_id or -1)
  if ok then Patrick.state.match_id = match_id end
end

Patrick.resolve_jump = function(backward)
  backward = backward or Patrick.state.backward
  local flags = backward and "Wb" or "W"

  F.search(Patrick.state.pattern, flags)

  vim.schedule(function()
    Patrick.state.active = true
    Patrick.watch_stop()
  end)
end

Patrick.update = function(n, backward, till)
  if not Patrick.state.active then
    Patrick.state.pattern = format_query(Patrick.get_query(n), backward, till)
    Patrick.state.till = till
    Patrick.state.backward = backward
  else
    Patrick.state.n_moves = 0
  end
end

Patrick.jump = function(n, backward, till)
  Patrick.update(n, backward, till)
  Patrick.highlight()
  Patrick.resolve_jump(backward)
end

Patrick.jump_op = function(n, backward, till)
  return function()
    Patrick.update(n, backward, till)
    return 'v<Cmd>lua Patrick.resolve_jump()<CR>'
  end
end
