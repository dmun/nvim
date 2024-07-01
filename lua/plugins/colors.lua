Plug("NvChad/nvim-colorizer.lua")
	:on(Event.BufReadPre, Event.BufNewFile)
	:opts {
		user_default_options = {
			names = false,
		}
	}

Plug("rachartier/tiny-devicons-auto-colors.nvim")
	:on(Event.VeryLazy)
	:dependencies("nvim-tree/nvim-web-devicons")
	:opts()

Plug("loganswartz/polychrome.nvim")
Plug("miikanissi/modus-themes.nvim")
Plug("dmun/fleet-theme-nvim")
Plug("lunacookies/vim-colors-xcode")
Plug("nanotech/jellybeans.vim")

Plug("ellisonleao/gruvbox.nvim") {
	contrast = "hard",
	bold = false,
	overrides = {
		CursorLineNr = { link = "GruvboxYellow" },
		DiagnosticOk = { link = "GruvboxGreen" },
		PmenuSel = { link = "Cursorline" },
		CmpItemAbbrMatch = { bold = true },
		CmpItemAbbrMatchFuzzy = { bold = true },
		-- GitSignsAdd = { link = "GruvboxGreenSign" },
		-- GitSignsChange = { link = "GruvboxAquaSign" },
		-- GitSignsDelete = { link = "GruvboxRedSign" },

		DiagnosticSignOk = { link = "GruvboxGreen" },
		DiagnosticSignHint = { link = "GruvboxAqua" },
		DiagnosticSignInfo = { link = "GruvboxBlue" },
		DiagnosticSignWarn = { link = "GruvboxYellow" },
		DiagnosticSignError = { link = "GruvboxRed" },

		TreesitterContextLineNumber = { fg = '#7C6F64', sp = '#3C3836', underline = true },
		TreesitterContext = { sp = '#3C3836', underline = true },

		DiagnosticUnderlineInfo = { sp = "#83a598", underline = true },
		DiagnosticUnderlineHint = { sp = "#8ec07c", underline = true },
		DiagnosticUnderlineError = { sp = "#fb4934", underline = true },
		DiagnosticUnderlineWarn = { sp = "#fabd2f", underline = true },
	},
}

Plug("catppuccin/nvim")
	:name("catppuccin")
	:opts {
		color_overrides = {
			frappe = {
				rosewater = "#FFAA43",
				flamingo = "#FFAA43",
				pink = "#CF92C9",
				mauve = "#CF92C9",
				red = "#FF5261",
				maroon = "#FF714C",
				peach = "#FFAA43",
				yellow = "#FFAA43",
				green = "#8CC98F",
				teal = "#36B7B5",
				sky = "#559BD1",
				sapphire = "#559BD1",
				blue = "#559BD1",
				lavender = "#CF92C9",
				text = "#D7DEEA",
				subtext1 = "#A5ACBA",
				subtext0 = "#828B96",
				overlay2 = "#71787F",
				overlay1 = "#6A727B",
				overlay0 = "#616870",
				surface2 = "#505A63",
				surface1 = "#39424C",
				surface0 = "#31353f",
				-- base = "#282c34",
				-- mantle = "#21252b",
				-- crust = "#181a1f",
				base = "#263238",
				mantle = "#1E272C",
				crust = "#1E272C",
			},
		},
		---@param colors CtpColors<CtpFlavor>
		custom_highlights = function(colors)
			return {
				PmenuSel = { fg = colors.none, bg = colors.surface1, style = {} },
				-- Pmenu = { bg = colors.mantle },
				CmpItemAbbr = { fg = colors.text },
				CmpItemAbbrMatch = { fg = colors.none, bold = true },
				CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
				CmpItemMenu = { fg = colors.overlay2 },
				CmpItemArgs = { fg = colors.overlay0 },

				TreesitterContext = { bg = colors.none },
				TreesitterContextLineNumber = { bg = colors.none },
			}
		end,
		_custom_highlights = function(colors)
			return {
				LineNr = { fg = colors.surface2 },
				CursorLineNr = { fg = colors.subtext1 },
				-- SignColumn = { bg = colors.surface1 },
				GitSignsAdd = { fg = "#466448" },
				GitSignsChange = { fg = "#7f5522" },
				GitSignsDelete = { fg = "#7f2931" },

				WinSeparator = { fg = colors.mantle, bg = colors.mantle },

				-- Folded = { bg = colors.none },
				UfoFoldedBg = { link = "DiffChange" },
				Folded = { link = "DiffChange" },
				FoldSign = { link = "CursorLineNr" },
				UfoFoldedEllipsis = { link = "NeogitHunkHeaderHighlight" },
				-- UfoFoldedEllipsis = { link = "DiffText" },

				nCursor = { bg = colors.peach },
				iCursor = { bg = colors.green },

				nCursorLineNr = { fg = colors.peach, bold = true },
				iCursorLineNr = { fg = colors.green, bold = true },

				PmenuSel = { bg = colors.surface2 },
				Pmenu = { fg = colors.subtext0, bg = colors.surface1 },
				CmpItemAbbr = { fg = colors.subtext0 },

				IlluminatedWord = { link = "DiffChange" },

				Delimiter = { fg = colors.subtext1 },
				Comment = { fg = colors.subtext1 },
				Structure = { fg = colors.blue },
				Type = { fg = colors.text },
				Function = { fg = colors.teal },
				Operator = { fg = colors.maroon },

				-- treesitter
				["@property"] = { fg = colors.text },
				["@namespace"] = { fg = colors.text },
				["@module"] = { fg = colors.text },
				["@keyword.modifier"] = { fg = colors.red },
				["@type.builtin"] = { fg = colors.mauve },
				["@type.builtin.cpp"] = { fg = colors.mauve },
				["@variable.builtin"] = { fg = colors.text },
				["@variable.parameter"] = { fg = colors.peach },
				["@variable.member"] = { fg = colors.text },
				["@function.builtin"] = { fg = colors.blue },
				["@function"] = { fg = colors.teal },
				["@function.call"] = { fg = colors.blue },
				["@punctuation.bracket"] = { fg = "white" },
				["@markup.heading"] = { fg = "white", bold = true, underline = true },
				["@markup.link.url.typst"] = { fg = "white", italic = true, underline = false },
				-- ["@operator.typst"] = { link = "@punctuation.bracket" },
				["@operator.typst"] = {},
				["@markup.link.label.typst"] = { link = "Label" },
				["@function.call.typst"] = { link = "Special" },
				["@markup.italic"] = { fg = "white", italic = true },

				-- semantic tokens
				["@lsp.type.function"] = {},
				["@lsp.typemod.namespace"] = { fg = colors.text },
				["@lsp.type.parameter"] = { fg = colors.peach },
				-- ["@lsp.mod.reference"] = { fg = colors.text },
				-- ["@lsp.typemod.parameter.declaration"] = { fg = colors.maroon },
			}
		end,
	}
