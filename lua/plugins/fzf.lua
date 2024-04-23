return {
	{
		"ibhagwan/fzf-lua",
		keys = {
			{ "<leader>f", "<cmd>Fzf files<cr>" },
			{ "<leader>l", "<cmd>Fzf oldfiles<cr>" },
			{ "<leader>/", "<cmd>Fzf live_grep<cr>" },
			{ "<leader>?", "<cmd>Fzf live_grep_resume<cr>" },
			{ "<leader>,", "<cmd>Fzf buffers<cr>" },
			{ "<leader><leader>", "<cmd>Fzf builtin<cr>" },
			{ "<M-CR>", "<cmd>Fzf lsp_code_actions<cr>" },
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
