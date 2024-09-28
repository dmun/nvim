return {
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
			user_default_options = {
				names = false,
			},
		},
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		opts = {
			color_overrides = {
				frappe = {
					rosewater = '#FFAA43',
					flamingo = '#FFAA43',
					pink = '#CF92C9',
					mauve = '#CF92C9',
					red = '#FF5261',
					maroon = '#FF714C',
					peach = '#FFAA43',
					yellow = '#FFAA43',
					green = '#8CC98F',
					teal = '#36B7B5',
					sky = '#559BD1',
					sapphire = '#559BD1',
					blue = '#559BD1',
					lavender = '#CF92C9',
					text = '#D7DEEA',
					subtext1 = '#A5ACBA',
					subtext0 = '#828B96',
					overlay2 = '#71787F',
					overlay1 = '#6A727B',
					overlay0 = '#616870',
					surface2 = '#505A63',
					surface1 = '#39424C',
					surface0 = '#31353f',
					-- base = "#282c34",
					-- mantle = "#21252b",
					-- crust = "#181a1f",
					base = '#263238',
					mantle = '#1E272C',
					crust = '#1E272C',
				},
			},
			---@param colors CtpColors<CtpFlavor>
			custom_highlights = function(colors)
				return {
					PmenuSel = { fg = colors.none, bg = colors.surface1, style = {} },
					-- Pmenu = { bg = colors.mantle },
					CmpItemAbbr = { fg = colors.text },
					CmpItemAbbrMatch = { fg = colors.none, bold = true },
					CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
					CmpItemMenu = { fg = colors.overlay2 },
					CmpItemArgs = { fg = colors.overlay0 },

					nCursor = { bg = colors.peach },
					iCursor = { bg = colors.green },

					TreesitterContext = { bg = colors.none },
					TreesitterContextLineNumber = { bg = colors.none },
				}
			end,
			_custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.surface2 },
					CursorLineNr = { fg = colors.subtext1 },
					-- SignColumn = { bg = colors.surface1 },
					GitSignsAdd = { fg = '#466448' },
					GitSignsChange = { fg = '#7f5522' },
					GitSignsDelete = { fg = '#7f2931' },

					WinSeparator = { fg = colors.mantle, bg = colors.mantle },

					-- Folded = { bg = colors.none },
					UfoFoldedBg = { link = 'DiffChange' },
					Folded = { link = 'DiffChange' },
					FoldSign = { link = 'CursorLineNr' },
					UfoFoldedEllipsis = { link = 'NeogitHunkHeaderHighlight' },
					-- UfoFoldedEllipsis = { link = "DiffText" },

					nCursor = { bg = colors.peach },
					iCursor = { bg = colors.green },

					nCursorLineNr = { fg = colors.peach, bold = true },
					iCursorLineNr = { fg = colors.green, bold = true },

					PmenuSel = { bg = colors.surface2 },
					Pmenu = { fg = colors.subtext0, bg = colors.surface1 },
					CmpItemAbbr = { fg = colors.subtext0 },

					IlluminatedWord = { link = 'DiffChange' },

					Delimiter = { fg = colors.subtext1 },
					Comment = { fg = colors.subtext1 },
					Structure = { fg = colors.blue },
					Type = { fg = colors.text },
					Function = { fg = colors.teal },
					Operator = { fg = colors.maroon },

					-- treesitter
					['@property'] = { fg = colors.text },
					['@namespace'] = { fg = colors.text },
					['@module'] = { fg = colors.text },
					['@keyword.modifier'] = { fg = colors.red },
					['@type.builtin'] = { fg = colors.mauve },
					['@type.builtin.cpp'] = { fg = colors.mauve },
					['@variable.builtin'] = { fg = colors.text },
					['@variable.parameter'] = { fg = colors.peach },
					['@variable.member'] = { fg = colors.text },
					['@function.builtin'] = { fg = colors.blue },
					['@function'] = { fg = colors.teal },
					['@function.call'] = { fg = colors.blue },
					['@punctuation.bracket'] = { fg = 'white' },
					['@markup.heading'] = { fg = 'white', bold = true, underline = true },
					['@markup.link.url.typst'] = { fg = 'white', italic = true, underline = false },
					-- ["@operator.typst"] = { link = "@punctuation.bracket" },
					['@operator.typst'] = {},
					['@markup.link.label.typst'] = { link = 'Label' },
					['@function.call.typst'] = { link = 'Special' },
					['@markup.italic'] = { fg = 'white', italic = true },

					-- semantic tokens
					['@lsp.type.function'] = {},
					['@lsp.typemod.namespace'] = { fg = colors.text },
					['@lsp.type.parameter'] = { fg = colors.peach },
					-- ["@lsp.mod.reference"] = { fg = colors.text },
					-- ["@lsp.typemod.parameter.declaration"] = { fg = colors.maroon },
				}
			end,
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
					CmpItemAbbrMatch = { bold = true },
					CmpItemAbbrMatchFuzzy = { bold = true },
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
	},
}
