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

function _G.loadvim(file)
  local path = vim.fn.stdpath("config") .. "/vim/" .. file .. ".vim"
  vim.cmd.source(path)
end

require("configs")
loadvim("options")
loadvim("keymaps")
loadvim("autocommands")

require("lazy").setup("plugins", {
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
