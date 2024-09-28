local util = require('util')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'

vim.api.nvim_set_keymap('v', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('v', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

util.handle_keymaps {
	n = {
		-- { 'u', '<cmd>undo<cr>' },
		-- { '<C-r>', '<cmd>silent redo<cr>' },

		{ '<M-s>', ':silent update<cr>' },
		{ '<M-a>', 'ggVG' },

		{ '<leader>tw', ':set wrap!<cr>' },
		{ '<leader>dl', ':messages<cr>' },

		{
			'<localleader>r',
			util.run_command,
		},
		{
			'<localleader>R',
			util.run_command_reset,
		},

		{ '<A-h>', '<C-w>h' },
		{ '<A-j>', '<C-w>j' },
		{ '<A-k>', '<C-w>k' },
		{ '<A-l>', '<C-w>l' },
	},
	i = {
		{ '<M-s>', '<esc>:silent update<cr>' },
		{ '<C-n>', '<cmd>norm j<cr>' },
		{ '<C-p>', '<cmd>norm k<cr>' },
	},
}
