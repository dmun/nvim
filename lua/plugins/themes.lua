return {
	{
		"marko-cerovac/material.nvim",
		opts = {
			high_visibility = {
				darker = true,
			},
			disable = {
				colored_cursor = false,
			},
		},
	},
	{
		"p00f/alabaster.nvim",
		enabled = false,
		priority = 1000,
		config = function()
			vim.g.alabaster_dim_comments = true
			vim.cmd.color("alabaster")

			require("util").set_highlights {
				LineNr = { fg = "#566062", bg = "#162022" },
				CursorLineNr = { link = "StatusLine" },
				SignColumn = { link = "StatusLine" },
				GitSignsAdd = { link = "StatusLineGreen" },
				GitSignsChange = { link = "StatusLineBlue" },
				GitSignsDelete = { link = "StatusLineRed" },
				DiagnosticSignOk = { link = "StatusLineGreen" },
				DiagnosticSignHint = { link = "StatusLineBlue" },
				DiagnosticSignInfo = { link = "StatusLineCyan" },
				DiagnosticSignWarn = { link = "StatusLineYellow" },
				DiagnosticSignError = { link = "StatusLineRed" },
			}
		end,
	},
	{
		"echasnovski/mini.nvim",
		enabled = false,
		name = "mini.base16",
		opts = {
			palette = {
				base00 = "#181818",
				base01 = "#282828",
				base02 = "#383838",
				base03 = "#585858",
				base04 = "#b8b8b8",
				base05 = "#d8d8d8",
				base06 = "#e8e8e8",
				base07 = "#f8f8f8",
				base08 = "#ab4642",
				base09 = "#dc9656",
				base0E = "#f7ca88",
				base0B = "#a1b56c",
				base0C = "#86c1b9",
				base0D = "#7cafc2",
				base0A = "#ba8baf",
				base0F = "#a16946",
			},
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			contrast = "hard",
			-- bold = false,
			overrides = {
				CursorLineNr = { link = "GruvboxYellow" },
				DiagnosticOk = { link = "GruvboxGreen" },
				-- 	PmenuSel = { link = "Cursorline" },
				-- GitSignsAdd = { link = "GruvboxGreenSign" },
				-- GitSignsChange = { link = "GruvboxAquaSign" },
				-- GitSignsDelete = { link = "GruvboxRedSign" },
				GruvboxGreenLabel = { fg = "#b8bb26", bg = "#252615" },
				GruvboxGreenBg = { bg = "#252615" },

				GruvboxAquaLabel = { fg = "#8ec07c", bg = "#1c2c16" },
				GruvboxAquaBg = { bg = "#1c2c16" },

				GruvboxBlueLabel = { fg = "#83a598", bg = "#172923" },
				GruvboxBlueBg = { bg = "#172923" },

				GruvboxYellowLabel = { fg = "#fabd2f", bg = "#3e3221" },
				GruvboxYellowBg = { bg = "#3e3221" },

				GruvboxRedLabel = { fg = "#fb4934", bg = "#36231f" },
				GruvboxRedBg = { bg = "#36231f" },

				DiagnosticVirtualTextOk = { link = "GruvboxGreen" },
				DiagnosticVirtualTextHint = { link = "GruvboxAqua" },
				DiagnosticVirtualTextInfo = { link = "GruvboxBlue" },
				DiagnosticVirtualTextWarn = { link = "GruvboxYellow" },
				DiagnosticVirtualTextError = { link = "GruvboxRed" },

				DiagnosticSignOk = { link = "GruvboxGreen" },
				DiagnosticSignHint = { link = "GruvboxAqua" },
				DiagnosticSignInfo = { link = "GruvboxBlue" },
				DiagnosticSignWarn = { link = "GruvboxYellow" },
				DiagnosticSignError = { link = "GruvboxRed" },

				DiagnosticUnderlineInfo = { sp = "#83a598", underline = true },
				DiagnosticUnderlineHint = { sp = "#8ec07c", underline = true },
				DiagnosticUnderlineError = { sp = "#fb4934", underline = true },
				DiagnosticUnderlineWarn = { sp = "#fabd2f", underline = true },
			},
		},
	},
	"dmun/fleet-theme-nvim",
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			color_overrides = {
				all = {
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
			custom_highlights = function(colors)
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
		},
	},
	"miikanissi/modus-themes.nvim",
}
