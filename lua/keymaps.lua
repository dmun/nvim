local util = require("util")

vim.g.mapleader = " "
vim.g.maplocalleader = " m"

vim.api.nvim_set_keymap("v", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("v", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

util.handle_keymaps {
	n = {
		-- { "$", "g$" },
		{ "0", "g0" },

		{ "u", "<cmd>silent undo<cr>" },
		{ "<C-r>", "<cmd>silent redo<cr>" },

		{ "<leader>w", "<cmd>silent update<cr>" },
		{ "<leader>tw", "<cmd>set wrap!<cr>" },

		{
			"<localleader>r",
			util.run_command,
		},
		{
			"<localleader>R",
			util.run_command_reset,
		},

		{ "<C-h>", "<C-w>h" },
		{ "<ESC>", "<C-w>j<ESC>" },
		{ "<C-k>", "<C-w>k" },
		{ "<C-l>", "<C-w>l" },
	},
	v = {
		-- { "$", "g$" },
		{ "0", "g0" },
	},
}
