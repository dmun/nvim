local path_package = vim.fn.stdpath("data") .. "/site/"
local function ensure_installed(plugin, branch)
  local user, repo = string.match(plugin, "(.+)/(.+)")
  local repo_path = path_package .. "pack/deps/start/" .. repo
  if not (vim.uv or vim.loop).fs_stat(repo_path) then
    vim.notify("Installing " .. plugin .. " " .. branch)
    local repo_url = "https://github.com/" .. plugin
    local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=" .. branch,
      repo_url,
      repo_path,
    })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone " .. plugin .. ":\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
    vim.cmd("packadd " .. repo .. " | helptags ALL")
    vim.cmd('echo "Installed `' .. repo .. '`" | redraw')
  end
end

ensure_installed("echasnovski/mini.nvim", "stable")
ensure_installed("rktjmp/hotpot.nvim", "v0.14.8")

require("hotpot").setup({
  enable_hotpot_diagnostics = false,
  compiler = {
    modules = {
      correlate = true,
    },
    macros = {
      env = "_COMPILER",
      compilerEnv = _G,
      allowGlobals = true,
    },
  },
})

require("mini.deps").setup({ path = { package = path_package } })
MiniDeps.add({ source = "echasnovski/mini.nvim", checkout = "stable" })
MiniDeps.add({ source = "rktjmp/hotpot.nvim", checkout = "v0.14.8" })

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

require("init")
