return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
				"query",
			},
			highlight = {
				enable = true,
			},
		}
	end,
}
