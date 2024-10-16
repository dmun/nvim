local util = require('util')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'

vim.api.nvim_set_keymap('x', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('x', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

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

		{ '<C-h>', '<C-w>h' },
		{ '<C-j>', '<C-w>j' },
		{ '<C-k>', '<C-w>k' },
		{ '<C-l>', '<C-w>l' },

		{ '<M-r>', '<cmd>MoltenReevaluateCell<cr>' },
		{ '<M-i>', '<cmd>MoltenImagePopup<cr>' },
		{ '<M-o>', '<cmd>autocmd MoltenEnterOutput<cr>' },
		{ '<leader>ra', '<cmd>MoltenReevaluateAll<cr>' },
		{ '<leader>ev', '<cmd>MoltenEvaluateVisual<cr>' },
	},
	i = {
		{ '<M-s>', '<esc>:silent update<cr>' },
		{ '<C-n>', '<cmd>norm j<cr>' },
		{ '<C-p>', '<cmd>norm k<cr>' },
	},
	v = {
		{ '<M-r>', '<cmd>MoltenEvaluateOperator<cr>' },
	},
}
