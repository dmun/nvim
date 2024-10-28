local util = require('util')

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.api.nvim_set_keymap('x', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('x', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

util.handle_keymaps({
	n = {
		{ '<leader>tw', ':set wrap!<cr>' },
		{ '<leader>dl', ':messages<cr>' },

		{ '<M-r>', util.run_command },
		{ '<M-x>', util.run_command_reset },

		{ '<C-d>', '<C-d>zz' },
		{ '<C-u>', '<C-u>zz' },

		{ '<M-s>', '<C-w>s' },
		{ '<M-v>', '<C-w>v' },

		{ '<M-h>', '<C-w>h' },
		{ '<M-j>', '<C-w>j' },
		{ '<M-k>', '<C-w>k' },
		{ '<M-l>', '<C-w>l' },
	},
	i = {
		{ '<M-s>', '<esc>:silent update<cr>' },
		{ '<C-n>', '<cmd>norm j<cr>' },
		{ '<C-p>', '<cmd>norm k<cr>' },
	},
})
