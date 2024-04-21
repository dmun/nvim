return {
	"glepnir/lspsaga.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		symbol_in_winbar = { enable = false },
		lightbulb = { virtual_text = false },
	},
}
