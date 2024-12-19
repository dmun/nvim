return {
	"dmun/leetcode.nvim",
	build = ":TSUpdate html",
	lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
	dependencies = {
		"ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		lang = "python3",
		description = { winhl = "" },
	},
}
