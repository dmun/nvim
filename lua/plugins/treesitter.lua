Plug('nvim-treesitter/nvim-treesitter-context')
	:opts {
		max_lines = 1,
		trim_scope = 'inner',
		mode = 'cursor',
	}

Plug('nvim-treesitter/nvim-treesitter')
	:on(Event.BufReadPre, Event.BufNewFile)
	:setup('nvim-treesitter.configs') {
		ensure_installed = {
			'lua',
			'luadoc',
			'vim',
			'vimdoc',
			'query',
		},
		highlight = {
			enable = true,
		},
		indent = {
			enable = false,
		},
	}
