return {
	"lukas-reineke/indent-blankline.nvim",
	enabled = false,
	config = function()
		require("ibl").setup {
			indent = {
				char = "▏",
			},
		}
	end,
}
