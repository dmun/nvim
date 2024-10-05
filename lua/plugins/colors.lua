local c = {
	fg0         = '#ffffff',
	fg1         = '#dddddd',
	fg2         = '#bbbbbb',
	fg3         = '#999999',
	bg          = { ['alt'] = '#16161d', ['selected'] = '#363646', ['base'] = '#1f1f28' },
	blue        = '#89B4FB',
	red         = '#FF5189',
	purple      = '#C8D7E8',
	cyan        = '#88C1D0',
	cyan1       = '#05A8C5',
	cyan2       = '#4ECDC4',
	yellow      = '#E9EE01',
	yellow1     = '#E3C78A',
	orange      = '#E69E67',
	green       = '#9ECE6A',
	green1      = '#8FBE01',
	red_fade    = '#261517',
	green_fade  = '#15261b',
	yellow_fade = '#262415',
	blue_fade   = '#152626',
}

return {
	'bluz71/vim-moonfly-colors',
	{ 'miikanissi/modus-themes.nvim', priority = 1000 },
	{
		'themercorp/themer.lua',
		opts = {
			plugins = {
				cmp = false,
			},
			remaps = {
				palette = {
					nord = {
						['accent'] = c.fg1,
						['border'] = c.fg2,
						['fg']     = c.fg1,
						['bg']     = { ['alt'] = '#16161d', ['base'] = '#363646', ['selected'] = '#1f1f28' },
						['pum'] = {
							['sbar']  = c.bg.base,
							['sel']   = { fg = 'none', bg = c.bg.alt },
							['bg']    = c.bg.base,
							['thumb'] = c.bg.alt,
						},
						['gitsigns'] = {
							['remove'] = c.red_fade,
							['add']    = c.green_fade,
							['change'] = c.yellow_fade,
						},
						['built_in'] = {
							['variable'] = c.green1,
							['function'] = c.green1,
							['constant'] = c.green1,
							['keyword']  = c.green1,
							['type']     = c.cyan2,
						},
						['syntax'] = {
							['function']    = c.cyan1,
							['property']    = c.fg0,
							['string']      = c.yellow,
							['number']      = c.yellow,
							['punctuation'] = c.fg2,
							['constructor'] = c.fg2,
							['keyword']     = c.yellow1,
							['constant']    = c.green1,
							['type']        = c.cyan2,
							['operator']    = c.fg1,
						},
					},
				},
				highlights = {
					globals = {
						base = {
							Cursor                  = { fg = c.fg1, bg = '#111111' },
							nCursor                 = { bg = c.red},
							iCursor                 = { bg = c.yellow},
							Normal                  = { bg = '#000000' },
							SignColumn              = { link = 'Normal' },
							MultiCursorSign         = { link = 'LineNr' },
							CmpItemArgs             = { fg = '#777777'},
							CmpItemMenu             = { fg = c.fg2 },
							IlluminatedWordText     = { bg = '#111111' },
							IlluminatedWordRead     = { bg = '#111111' },
							IlluminatedWordWrite    = { bg = '#111111' },
							['@lsp.type.variable.zig'] = {},
						},
					},
				},
			},
		},
	},
	{
		'rachartier/tiny-devicons-auto-colors.nvim',
		event = 'VeryLazy',
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {},
	},
	{
		'NvChad/nvim-colorizer.lua',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			filetypes = {
				'*',
				'!noice',
			},
			user_default_options = {
				names = false,
			},
		},
	},
	{
		'catppuccin/nvim',
		lazy = false,
		name = 'catppuccin',
		priority = 1000,
		opts = {
			---@param c CtpColors<CtpFlavor>
			custom_highlights = function(c)
				return {
					PmenuSel = { fg = c.none, bg = c.surface1, style = {} },
					-- Pmenu = { bg = c.mantle },
					CmpItemAbbr = { fg = c.text },
					CmpItemAbbrMatch = { fg = c.none, style = { 'bold' } },
					CmpItemAbbrMatchDefault = { link = 'CmpItemAbbrMatch' },
					CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
					CmpItemMenu = { fg = c.overlay2 },
					CmpItemArgs = { fg = c.overlay0 },

					nCursor = { bg = c.peach },
					iCursor = { bg = c.green },

					TreesitterContext = { bg = c.none },
					TreesitterContextLineNumber = { bg = c.none },
				}
			end,
		},
	},
	{
		'ellisonleao/gruvbox.nvim',
		opts = {
			contrast = 'hard',
			bold = false,
			overrides = {
				iCursor = { bg = '#D3859B' },
				nCursor = { bg = '#FBBD2E' },
				CursorLineNr = { link = 'GruvboxYellow' },
				DiagnosticOk = { link = 'GruvboxGreen' },
				PmenuSel = { link = 'Cursorline' },
				CmpItemMenu = { fg = '#A79A84', bg = 'none' },
				CmpItemArgs = { link = 'Comment' },
				CmpItemAbbrMatch = { bold = true },
				CmpItemAbbrMatchFuzzy = { bold = true },
				SignColumn = { link = 'Normal' },
				-- GitSignsAdd = { link = "GruvboxGreenSign" },
				-- GitSignsChange = { link = "GruvboxAquaSign" },
				-- gitsignsdelete = { link = "gruvboxredsign" },

				diagnosticsignok = { link = 'gruvboxgreen' },
				diagnosticsignhint = { link = 'gruvboxaqua' },
				diagnosticsigninfo = { link = 'gruvboxblue' },
				diagnosticsignwarn = { link = 'gruvboxyellow' },
				diagnosticsignerror = { link = 'gruvboxred' },

				treesittercontextlinenumber = { fg = '#7c6f64', sp = '#3c3836', underline = true },
				treesittercontext = { sp = '#3c3836', underline = true },

				diagnosticunderlineinfo = { sp = '#83a598', underline = true },
				diagnosticunderlinehint = { sp = '#8ec07c', underline = true },
				diagnosticunderlineerror = { sp = '#fb4934', underline = true },
				diagnosticunderlinewarn = { sp = '#fabd2f', underline = true },
			},
		},
	},
}
