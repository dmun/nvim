return {
	"ibhagwan/fzf-lua",
	keys = {
		{ "<leader>f", "<cmd>Fzf files<cr>" },
		{ "<leader>l", "<cmd>Fzf oldfiles<cr>" },
		{ "<leader>/", "<cmd>Fzf live_grep<cr>" },
		{ "<leader>?", "<cmd>Fzf live_grep_resume<cr>" },
		{ "<leader>,", "<cmd>Fzf buffers<cr>" },
		{ "<leader><leader>", "<cmd>Fzf builtin<cr>" },
	},
	opts = {
		files = {
			cmd = "rg --files --hidden",
		},
	},
}
