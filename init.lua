local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("configs")
require("options")
require("keymaps")
require("autocommands")

local colorscheme = "jellybeans"
require("lazy").setup("plugins", {
  install = { colorscheme = { colorscheme } },
  change_detection = { enabled = false },
  ui = {
    pills = true,
    backdrop = 100,
    size = { width = 1.0, height = 0.99 },
  },
  dev = {
    path = "~/Development",
    fallback = true,
  },
})
vim.cmd.color(colorscheme)
