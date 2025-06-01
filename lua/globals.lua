_G.add = MiniDeps.add
_G.now = MiniDeps.now
_G.later = MiniDeps.later

_G.db = function(...) vim.notify(vim.inspect(...)) end

_G.au = function(event, pattern, callback, group, buffer)
  return vim.api.nvim_create_autocmd(
    event,
    { pattern = pattern, callback = callback, buffer = buffer, group = group }
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
  local options = { silent = true }
  if not opts and not rhs then
    rhs = lhs
    lhs = mode
    mode = { "n", "x", "o" }
  end
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

_G.remap = function(mode, lhs, rhs, opts)
  if not opts and not rhs then
    rhs = lhs
    lhs = mode
    mode = { "n", "x", "o" }
  end
  map(mode, lhs, rhs, vim.tbl_extend("force", opts or {}, { remap = true }))
end

_G.nmap = bind(map, "n")
_G.vmap = bind(map, "v")
_G.xmap = bind(map, "x")
_G.imap = bind(map, "i")
_G.tmap = bind(map, "t")
_G.omap = function(lhs, rhs)
  map("o", lhs, rhs, { expr = true })
end

_G.iremap = bind(remap, "i")
