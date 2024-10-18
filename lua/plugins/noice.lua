return {
	'folke/noice.nvim',
	event = 'VeryLazy',
	dependencies = 'MunifTanjim/nui.nvim',
	opts = {
		lsp = { signature = { enabled = false } },
		views = {
			cmdline_popup = {
				position = {
					row = '33%',
					col = '50%',
				},
				border = {
					style = 'single',
				},
			},
		},
	},
}
