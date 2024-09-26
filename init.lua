local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

_G.Plug = require('util.plug')
local plugins_path = vim.fn.stdpath('config') .. '/lua/plugins'
if vim.loop.fs_stat(plugins_path) then
	for file in vim.fs.dir(plugins_path) do
		file = file:match('^(.*)%.lua$')
		require('plugins.' .. file)
	end
end
for _, spec in pairs(_G.Plug.specs) do
	setmetatable(spec, {})
end

require('configs')
require('options')
require('keymaps')
require('autocommands')
require('sandbox')

require('lazy').setup(_G.Plug.specs, {
	change_detection = {
		enabled = false,
	},
})

-- require("profiler")

-- vim.lsp.set_log_level("debug")
-- vim.lsp.log.set_format_func(vim.inspect)

-- require("util").set_colorscheme()
vim.cmd.color("catppuccin")
