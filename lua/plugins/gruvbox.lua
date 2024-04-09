return {
	"ellisonleao/gruvbox.nvim",
	enabled = true,
	lazy = false,
	priority = 1000,
	opts = {
		contrast = "hard",
	},
	config = function(_, opts)
		require("gruvbox").setup(opts)
		vim.cmd.colorscheme("gruvbox")
	end,
}
