return {
	{
		"p00f/alabaster.nvim",
		priority = 1000,
		config = function()
			vim.g.alabaster_dim_comments = true
			vim.cmd.color("alabaster")

			-- require("util").set_highlights {
			-- 	LineNr = { fg = "#566062", bg = "#162022" },
			-- 	CursorLineNr = { link = "StatusLine" },
			-- 	SignColumn = { link = "StatusLine" },
			-- 	GitSignsAdd = { link = "StatusLineGreen" },
			-- 	GitSignsChange = { link = "StatusLineBlue" },
			-- 	GitSignsDelete = { link = "StatusLineRed" },
			-- }
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
		opts = {
			color_overrides = {
				mocha = {
					rosewater = "#ffc9c9",
					flamingo = "#ff9f9a",
					pink = "#ffa9c9",
					mauve = "#df95cf",
					lavender = "#a990c9",
					red = "#ff6960",
					maroon = "#f98080",
					peach = "#f9905f",
					yellow = "#f9bd69",
					green = "#b0d080",
					teal = "#a0dfa0",
					sky = "#a0d0c0",
					sapphire = "#95b9d0",
					blue = "#89a0e0",
					text = "#e0d0b0",
					subtext1 = "#d5c4a1",
					subtext0 = "#bdae93",
					overlay2 = "#928374",
					overlay1 = "#7c6f64",
					overlay0 = "#665c54",
					surface2 = "#504844",
					surface1 = "#3a3634",
					surface0 = "#252525",
					base = "#151515",
					mantle = "#0e0e0e",
					crust = "#080808",
				},
			},
		},
	},
	"miikanissi/modus-themes.nvim",
}
