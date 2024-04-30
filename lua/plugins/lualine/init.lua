return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local gruvbox = require("lualine.themes.gruvbox")
		local util = require("util")

		gruvbox.normal.a = { fg = "#7C6F64", bg = "#282828" }
		gruvbox.normal.c = { fg = gruvbox.normal.c.fg, bg = "#303030" }
		gruvbox.normal.y = gruvbox.normal.a
		gruvbox.normal.z = gruvbox.command.c
		gruvbox.inactive = util.deepcopy(gruvbox.normal)

		require("lualine").setup {
			options = {
				-- theme = require("plugins.lualine.theme"),
				component_separators = { left = nil, right = nil },
				section_separators = { left = nil, right = nil },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "mode", { "filename", path = 4 } },
				lualine_x = { "diagnostics", "progress", "location" },
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					function()
						return "      "
					end,
					{ "filename", path = 4 },
				},
				lualine_x = { "diagnostics", "progress", "location" },
				lualine_y = {},
				lualine_z = {},
			},
		}
	end,
}
