local custom_filename = {
	'filename',
	path = 4,
	symbols = {
		modified = '󰏫', -- Text to show when the file is modified.
		readonly = '', -- Text to show when the file is non-modifiable or readonly.
		unnamed = '*scratch*', -- Text to show for unnamed buffers.
		newfile = '*new*', -- Text to show for newly created file before first write
	},
}

return {
	'nvim-lualine/lualine.nvim',
	-- enabled = false,
	opts = {
		options = {
			theme = 'auto',
			component_separators = { left = nil, right = nil },
			section_separators = { left = nil, right = nil },
			always_divide_middle = true,
			disabled_filetypes = {
				statusline = {
					'NvimTree',
					'fzf',
					'trouble',
				},
			},
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				custom_filename,
				'diagnostics',
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				custom_filename,
				'diagnostics',
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	},
}
