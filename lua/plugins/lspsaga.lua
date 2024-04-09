vim.keymap.set("n", "<M-CR>", "<cmd>Lspsaga code_action<cr>")

return {
	"glepnir/lspsaga.nvim",
	opts = {
		ui = {
			title = false,
		},
		hover = {
			max_height = 0.5,
		},
		diagnostic = {
			show_code_action = false,
		},
		symbol_in_winbar = {
			enable = false,
		},
		lighbulb = {
			virtual_text = false,
		},
		code_action = {
			keys = { quit = "<ESC>" },
		},
		rename = {
			keys = { quit = "<ESC>" },
		},
	},
}
