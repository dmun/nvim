local project = {
	function()
		local path = vim.fn.getcwd()
		return vim.fs.basename(path)
	end,
	color = { fg = '#9c9c78', gui = 'bold' },
}

local filename = {
	function()
		if vim.bo.filetype == 'help' then
			return 'Neovim Documentation'
		end

		local path = vim.fn.expand('%:.')

		if path:find('oil://') then
			path = path:sub(7)
		end

		return path
	end,
	color = function()
		local fg = '#cccccc'
		local gui = ''

		if vim.bo.modifiable == false then
			fg = '#777777'
		end

		if vim.bo.modified then
			gui = 'italic'
		end

		return { fg = fg, gui = gui }
	end,
}

return {
	'nvim-lualine/lualine.nvim',
	opts = {
		options = {
			theme = 'auto',
			component_separators = { left = nil, right = nil },
			section_separators = { left = nil, right = nil },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { project, filename },
			lualine_x = { 'diagnostics' },
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { project, filename },
			lualine_x = { 'diagnostics' },
			lualine_y = {},
			lualine_z = {},
		},
	},
}
