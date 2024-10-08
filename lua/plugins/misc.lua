return {
	-- 'darfnk/vim-plist',
	-- 'stevearc/profile.nvim'
	{ 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },
	{
		'quarto-dev/quarto-nvim',
		dependencies = {
			'jmbuhr/otter.nvim',
			'nvim-treesitter/nvim-treesitter',
		},
	},
	{
		'pappasam/nvim-repl',
		init = function()
			vim.g['repl_filetype_commands'] = {
				javascript = 'node',
				python = 'ipython --no-autoindent',
			}
		end,
		keys = {
			{ '<leader>rt', '<cmd>ReplToggle<cr>', desc = 'Toggle nvim-repl' },
			{ '<C-g>', '<cmd>ReplRunCell<cr>', desc = 'nvim-repl run cell' },
		},
	},
}
