return {
	"airblade/vim-rooter",
	{
		"stevearc/oil.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = { { "-", "<cmd>Oil<cr>" } },
		opts = {
			view_options = {
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".") or vim.endswith(name, ".pdf")
				end,
			},
			win_options = {
				number = false,
				relativenumber = false,
				wrap = false,
				signcolumn = "yes",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},
		},
	},
	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		keys = {
			{ "<leader>g", "<cmd>Grapple toggle_tags<cr>" },
			{ "<leader>m", "<cmd>Grapple tag<cr>" },
			{ "<M-1>", "<cmd>Grapple select index=1<cr>" },
			{ "<M-2>", "<cmd>Grapple select index=2<cr>" },
			{ "<M-3>", "<cmd>Grapple select index=3<cr>" },
			{ "<M-4>", "<cmd>Grapple select index=4<cr>" },
			{ "<M-5>", "<cmd>Grapple select index=5<cr>" },
		},
		opts = {
			scope = "cwd",
			statusline = {
				icon = "",
			},
		},
	},
}
