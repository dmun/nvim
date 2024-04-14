local util = require("util")

vim.g.mapleader = " "
vim.g.maplocalleader = " m"

util.handle_keymaps {
	n = {
		{ "<ESC>", "<ESC><cmd>LuaSnipUnlinkCurrent<cr>" },

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
		{ "<C-j>", "<C-w>j" },
		{ "<C-k>", "<C-w>k" },
		{ "<C-l>", "<C-w>l" },
	},
	i = {
		{ "<ESC>", "<ESC><cmd>LuaSnipUnlinkCurrent<cr>" },

		{ "<C-h>", "<C-w>h" },
		{ "<C-j>", "<C-w>j" },
		{ "<C-k>", "<C-w>k" },
		{ "<C-l>", "<C-w>l" },
	},
}
