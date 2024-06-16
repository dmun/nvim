local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require("configs")
require("options")
require("keymaps")
require("autocommands")
require("util.plug")

require("lazy").setup({
	{ import = "plugins" },
	{ import = "plug" },
}, {
	change_detection = {
		enabled = false,
	},
})

vim.cmd.color("gruvbox")
