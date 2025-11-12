_G.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- stylua: ignore start
_G.nmap = function(lhs, rhs, opts) map("n", lhs, rhs, opts) end
_G.vmap = function(lhs, rhs, opts) map("v", lhs, rhs, opts) end
_G.xmap = function(lhs, rhs, opts) map("x", lhs, rhs, opts) end
_G.imap = function(lhs, rhs, opts) map("i", lhs, rhs, opts) end
_G.tmap = function(lhs, rhs, opts) map("t", lhs, rhs, opts) end
_G.omap = function(lhs, rhs) map("o", lhs, rhs, { expr = true }) end

_G.install = function (plugins)
  vim.pack.add(
    vim.tbl_map(function(spec)
      local git = "https://github.com/"
      if type(spec) == "table" then
        spec.src = git .. (spec[1] or spec.src)
        return spec
      end
      return { src = git .. spec }
    end, plugins),
    { confirm = false }
  )
end
