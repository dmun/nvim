local custom_filename = {
	'filename',
	path = 1,
	symbols = {
		modified = '󰏫', -- Text to show when the file is modified.
		readonly = '', -- Text to show when the file is non-modifiable or readonly.
		unnamed = '*scratch*', -- Text to show for unnamed buffers.
		newfile = '*new*', -- Text to show for newly created file before first write
	},
	padding = 0,
	color = { fg = '#cccccc' },
}

local project = {
	function()
		local path = vim.fn.getcwd()
		local text = vim.fs.basename(path)
		return '' .. text .. ''
	end,
	color = { fg = '#9c9c78', gui = 'bold' },
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
					-- 'fzf',
					'trouble',
				},
			},
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				project,
				custom_filename,
			},
			lualine_x = { 'diagnostics' },
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				project,
				custom_filename,
			},
			lualine_x = { 'diagnostics' },
			lualine_y = {},
			lualine_z = {},
		},
	},
}
