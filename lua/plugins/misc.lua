return {
	-- 'darfnk/vim-plist',
	-- 'stevearc/profile.nvim'
	{ 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },
	{
		'quarto-dev/quarto-nvim',
		ft = 'quarto',
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
			-- vim.g.molten_output_win_hide_on_leave = false
			vim.g.molten_output_win_style = 'minimal'
			vim.g.molten_tick_rate = 100

			vim.g.molten_enter_output_behavior = 'open_and_enter'
			vim.g.molten_output_win_max_height = 12
			vim.g.molten_auto_open_output = false
			vim.g.molten_auto_image_popup = true
			vim.g.molten_output_virt_lines = false
			vim.g.molten_virt_text_output = true
			vim.g.molten_cover_empty_lines = false
			vim.g.molten_output_win_border = { '', '', '', '' }
			vim.g.molten_output_win_cover_gutter = false
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
	{
		'R-nvim/R.nvim',
		-- Only required if you also set defaults.lazy = true
		lazy = false,
		-- R.nvim is still young and we may make some breaking changes from time
		-- to time. For now we recommend pinning to the latest minor version
		-- like so:
		version = '~0.1.0',
		config = function()
			-- Create a table with the options to be passed to setup()
			local opts = {
				hook = {
					on_filetype = function()
						vim.api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<Plug>RDSendLine', {})
						vim.api.nvim_buf_set_keymap(0, 'v', '<Enter>', '<Plug>RSendSelection', {})
					end,
				},
				R_args = { '--quiet', '--no-save' },
				min_editor_width = 72,
				rconsole_width = 78,
				-- objbr_mappings = { -- Object browser keymap
				-- 	c = 'class', -- Call R functions
				-- 	['<localleader>gg'] = 'head({object}, n = 15)', -- Use {object} notation to write arbitrary R code.
				-- 	v = function()
				-- 		-- Run lua functions
				-- 		require('r.browser').toggle_view()
				-- 	end,
				-- },
				disable_cmds = {
					'RClearConsole',
					'RCustomStart',
					'RSPlot',
					'RSaveClose',
				},
			}
			-- Check if the environment variable "R_AUTO_START" exists.
			-- If using fish shell, you could put in your config.fish:
			-- alias r "R_AUTO_START=true nvim"
			if vim.env.R_AUTO_START == 'true' then
				opts.auto_start = 'on startup'
				opts.objbr_auto_start = true
			end
			require('r').setup(opts)
		end,
	},
}
