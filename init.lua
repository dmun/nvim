vim.g.doom_one_cursor_coloring = 1
map = vim.api.nvim_set_keymap

-- Plugins
require "impatient"
require "plugins"

-- Vim settings
vim.cmd "source $HOME/.config/nvim/.vimrc"

-- Plugin settings
require "config.colorizer"
require "config.lspkind"
require "config.cmp"
require "config.gitsigns"
require "config.lspconfig"
require "config.lspinstall"
require "config.lualine"
require "config.null-ls"
require "config.packer"
require "config.pairs"
require "config.telescope"
require "config.treesitter"
require "config.tree"
require "config.indentline"

vim.keymap.set("n", "<M-S-f>", function () vim.lsp.buf.format { async = true } end, { silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.cmd "color doom-one"
vim.cmd "autocmd BufEnter * if &bt != 'nofile' | setlocal winhl=Normal:NormalBuffer"
