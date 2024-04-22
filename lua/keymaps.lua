local util = require("util")

vim.g.mapleader = " "
vim.g.maplocalleader = " m"

util.handle_keymaps {
	n = {
		{ "<leader>w", "<cmd>w<cr>" },
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
}
