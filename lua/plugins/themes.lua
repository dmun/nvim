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
		opts = {},
	},
	"miikanissi/modus-themes.nvim",
}
