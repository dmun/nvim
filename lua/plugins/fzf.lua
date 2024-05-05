return {
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		keys = {
			{ "<leader>f", "<cmd>FzfLua files<cr>" },
			{ "<leader>l", "<cmd>FzfLua oldfiles<cr>" },
			{ "<leader>/", "<cmd>FzfLua live_grep<cr>" },
			{ "<leader>?", "<cmd>FzfLua live_grep_resume<cr>" },
			{ "<leader>,", "<cmd>FzfLua buffers<cr>" },
			{ "<leader><leader>", "<cmd>FzfLua builtin<cr>" },
		},
		opts = {
			files = {
				cmd = "rg --files --hidden",
				no_header_i = true,
				file_icons = false,
				-- git_icons = false,
			},
			grep = { no_header_i = true },
			buffers = { no_header_i = true },
			winopts = {
				split = "botright new",
				preview = {
					hidden = "hidden",
				},
			},
		},
	},
}
