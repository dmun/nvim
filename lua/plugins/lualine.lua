return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			component_separators = { left = nil, right = nil },
			section_separators = { left = nil, right = nil },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "diagnostics", "location" },
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {
				function()
					return "      "
				end,
			},
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "diagnostics", "location" },
			lualine_y = {},
			lualine_z = {},
		},
	},
}
