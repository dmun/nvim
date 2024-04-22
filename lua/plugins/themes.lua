return {
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
				GruvboxRedUnderline = { underline = true, undercurl = false },
				GruvboxAquaUnderline = { underline = true, undercurl = false },
				GruvboxYellowUnderline = { underline = true, undercurl = false },
				GruvboxGreenUnderline = { underline = true, undercurl = false },
				GruvboxBlueUnderline = { underline = true, undercurl = false },
				GruvboxOrangeUnderline = { underline = true, undercurl = false },
				GruvboxPurpleUnderline = { underline = true, undercurl = false },
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