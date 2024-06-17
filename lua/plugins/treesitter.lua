Plug("nvim-treesitter/nvim-treesitter")
	:on(Event.BufReadPre, Event.BufNewFile)
	:opts("nvim-treesitter.configs") {
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
		indent = {
			enable = false,
		}
	}
