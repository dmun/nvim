return {
	-- 'romainl/vim-cool',
	'echasnovski/mini.nvim',
	{ 'numToStr/Comment.nvim', event = 'VeryLazy' },
	{ 'kylechui/nvim-surround', event = 'VeryLazy' },
	{ 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
	-- { 'VidocqH/auto-indent.nvim', event = 'InsertEnter' },
	{
		'lukas-reineke/indent-blankline.nvim',
		enabled = false,
		name = 'ibl',
		opts = {
			indent = {
				char = '▏',
			},
			scope = { enabled = false },
		},
	},
	{
		'RRethy/vim-illuminate',
		config = function()
			require('illuminate').configure {
				providers = { 'lsp', 'treesitter' },
			}
		end,
	},
	{
		'NMAC427/guess-indent.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {},
	},
	{
		'kosayoda/nvim-lightbulb',
		enabled = false,
		opts = {
			autocmd = { enabled = true },
			sign = {
				text = '',
				hl = 'DiagnosticWarn',
			},
		},
	},
	{
		'kevinhwang91/nvim-ufo',
		event = { 'BufRead', 'BufNewFile' },
		dependencies = { 'kevinhwang91/promise-async' },
		opts = {
			provider_selector = function()
				return { 'treesitter', 'indent' }
			end,
		},
	},
	{
		'folke/trouble.nvim',
		opts = {
			focus = true,
		},
	},
}
