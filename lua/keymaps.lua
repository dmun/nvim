local util = require("util")

vim.g.mapleader = " "
vim.g.maplocalleader = " m"

util.handle_keymaps {
	n = {
		{ "<leader>w", "<cmd>w<cr>" },
		{ "<leader>tw", "<cmd>set wrap!<cr>" },

		{ "<C-h>", "<C-w>h" },
		{ "<C-j>", "<C-w>j" },
		{ "<C-k>", "<C-w>k" },
		{ "<C-l>", "<C-w>l" },
	},
	i = {
		{ "<C-h>", "<C-w>h" },
		{ "<C-j>", "<C-w>j" },
		{ "<C-k>", "<C-w>k" },
		{ "<C-l>", "<C-w>l" },
	},
}
