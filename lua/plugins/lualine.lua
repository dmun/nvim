local mode = {
	function()
		return '▍'
	end,
	padding = 0,
	color = { gui = 'reverse' },
	-- color = 'lualine_a_insert',
}

local project = {
	function()
		local path = vim.fn.getcwd()
		return vim.fs.basename(path)
	end,
	color = { gui = 'bold' },
}

local filename = {
	function()
		local ft = vim.bo.filetype
		local bt = vim.bo.buftype
		local path = vim.fn.expand('%:.')

		if ft == 'help' then
			return 'Neovim Documentation'
		elseif bt == 'terminal' then
			if path:find('ipython') then
				path = 'IPython Kernel'
			end
			if path:find('oil://') then
				path = path:sub(7)
			end
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
			lualine_a = { mode },
			lualine_b = {},
			lualine_c = { project, filename, 'diagnostics' },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = { mode },
			lualine_b = {},
			lualine_c = { project, filename, 'diagnostics' },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	},
}
