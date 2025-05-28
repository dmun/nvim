_G.add = MiniDeps.add
_G.now = MiniDeps.now
_G.later = MiniDeps.later

_G.au = function(event, pattern, callback, buffer)
  vim.api.nvim_create_autocmd(
    event,
    { pattern = pattern, callback = callback, buffer = buffer }
  )
end

_G.bind = function(fn, ...)
  local args = { ... }
  return function(...)
    if select("#", ...) > 0 then
      fn(unpack(args), ...)
    else
      fn(unpack(args))
    end
  end
end

_G.cmd = vim.cmd

_G.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

_G.nmap = bind(map, "n")
_G.vmap = bind(map, "v")
_G.xmap = bind(map, "x")
_G.imap = bind(map, "i")
_G.tmap = bind(map, "t")
