return {
	"ellisonleao/gruvbox.nvim",
	enabled = true,
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox").setup {
			contrast = "hard",
		}
		vim.cmd.colorscheme("gruvbox")
	end,
}
