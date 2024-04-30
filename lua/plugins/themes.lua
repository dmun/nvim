return {
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
			bold = false,
			overrides = {
				LineNr = { bg = "#3C3836" },
				PmenuSel = { link = "Cursorline" },
				GitSignsAdd = { link = "GruvboxGreenSign" },
				GitSignsChange = { link = "GruvboxAquaSign" },
				GitSignsDelete = { link = "GruvboxRedSign" },
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
					base = "#282c34",
					mantle = "#21252b",
					crust = "#181a1f",
				},
			},
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.subtext0, bg = colors.surface1 },
					CursorLineNr = { fg = colors.text, bg = colors.surface1 },
					SignColumn = { bg = colors.surface1 },
					GitSignsAdd = { fg = colors.green, bg = colors.surface1 },
					GitSignsChange = { fg = colors.peach, bg = colors.surface1 },
					GitSignsDelete = { fg = colors.red, bg = colors.surface1 },

					-- CursorLineNr = { fg = colors.peach, bold = true },
					-- PmenuSel = { bg = colors.surface1 },
					Pmenu = { fg = colors.subtext1 },
					CmpItemAbbr = { fg = colors.subtext1 },

					IlluminatedWord = { bg = colors.surface0 },

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
					["@punctuation.bracket"] = { fg = "WHITE" },

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
