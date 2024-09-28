return {
	{
		'nvim-treesitter/nvim-treesitter-context',
		opts = {
			max_lines = 1,
			trim_scope = 'inner',
			mode = 'cursor',
		},
	},
	{
		'nvim-treesitter/nvim-treesitter',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			require('nvim-treesitter.configs').setup {
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
		end,
	},
}
