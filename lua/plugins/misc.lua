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
		opts = {
			codeRunner = {
				enabled = true,
				default_method = 'molten',
			},
		},
	},
	{
		-- 'benlubas/molten-nvim',
		dir = '~/Development/molten-nvim',
		-- version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
		-- enabled = false,
		dependencies = { '3rd/image.nvim', 'vhyrro/luarocks.nvim' },
		build = ':UpdateRemotePlugins',
		init = function()
			-- this is an example, not a default. Please see the readme for more configuration options
			-- vim.g.molten_image_provider = 'image.nvim'
			-- vim.g.molten_auto_image_popup = true
			-- vim.g.molten_image_location = 'virt'
			-- vim.g.molten_output_win_hide_on_leave = false
			-- vim.g.molten_output_win_style = 'minimal'
			vim.g.molten_tick_rate = 100

            vim.g.molten_enter_output_behavior = 'open_and_enter'
			vim.g.molten_output_win_max_height = 12
			-- vim.g.molten_auto_open_output = false
			vim.g.molten_output_virt_lines = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_cover_empty_lines = true
            -- vim.g.molten_virt_lines_off_by_1 = true
		end,
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
			-- { '<leader>rt', '<cmd>ReplToggle<cr>', desc = 'Toggle nvim-repl' },
			-- { '<C-g>', '<cmd>ReplRunCell<cr>', desc = 'nvim-repl run cell' },
		},
	},
}
