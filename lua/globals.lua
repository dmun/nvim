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
    vim.iter(plugins)
    :filter(function(spec)
      if type(spec) ~= "table" then
        return true
      end

      if not spec.dev then
        return true
      end

      local path = vim.fn.expand("~/dev/" .. string.gsub(spec.dev, "^.*%/", ""))
      if not vim.fn.filereadable(path) then
        return true
      end

      vim.opt.runtimepath:append(path)
      return false
    end)
    :map(function(spec)
      local git = "https://github.com/"

      if type(spec) == "string" then
        return { src = git .. spec }
      end

      if type(spec) == "table" then
        if spec[1] then
          spec.src = git .. spec[1]
        end
        return spec
      end
    end):totable(),
    { confirm = false }
  )
end
