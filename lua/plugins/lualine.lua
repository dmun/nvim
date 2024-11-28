local colors = {
	black = "#1D3B53",
	white = "#D7DBDF",
	red = "#1D3B53",
	green = "#1D3B53",
	blue = "#1D3B53",
	yellow = "#1D3B53",
	gray = "#1D3B53",
	darkgray = "#1D3B53",
	lightgray = "#1D3B53",
	inactivegray = "#1D3B53",
}

local theme = {
	normal = {
		a = { bg = colors.gray, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.darkgray, fg = colors.white },
	},
	insert = {
		a = { bg = colors.blue, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.lightgray, fg = colors.white },
	},
	visual = {
		a = { bg = colors.yellow, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.inactivegray, fg = colors.white },
	},
	replace = {
		a = { bg = colors.red, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.white, fg = colors.white },
	},
	command = {
		a = { bg = colors.green, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.inactivegray, fg = colors.white },
	},
	inactive = {
		a = { bg = colors.darkgray, fg = colors.white, gui = "bold" },
		b = { bg = colors.darkgray, fg = colors.white },
		c = { bg = colors.darkgray, fg = colors.white },
	},
}

local block = {
	function()
		return " "
	end,
	color = "Normal",
	padding = 0,
}

local macro = {
	function()
		local recording_register = vim.fn.reg_recording()
		if recording_register == "" then
			return ""
		else
			return "Recording @" .. recording_register
		end
	end,
	color = { gui = "bold" },
}

local multicursor = {
	icon = { "󰬸", color = { fg = "#80A4C2" } },
	function()
		local n = require("multicursor-nvim").numCursors()
		return n > 1 and n or ""
	end,
	color = { gui = "bold" },
}

local mode = {
	function()
		return "▍"
	end,
	padding = 0,
	color = { gui = "reverse" },
}

local project = {
	function()
		local path = vim.fn.getcwd()
		return "(" .. vim.fs.basename(path) .. ")"
	end,
	color = { fg = "#d7dbe0", gui = "bold" },
}

local filename = {
	function()
		local ft = vim.bo.filetype
		local bt = vim.bo.buftype
		local path = vim.fn.expand("%:.")
		if #path > 25 then
			path = vim.fn.pathshorten(path)
		end

		if ft == "help" then
			return "Neovim Documentation"
		elseif bt == "terminal" then
			if path:find("ipython") then
				path = "IPython Kernel"
			end
			if path:find("oil://") then
				path = path:sub(7)
			end
		end

		return path
	end,
	color = function()
		local fg = colors.white
		local gui = ""

		if vim.bo.modifiable == false then
			fg = "#777777"
		end

		if vim.bo.modified then
			gui = "italic"
		end

		return { fg = fg, gui = gui }
	end,
}

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = theme,
			component_separators = { left = nil, right = nil },
			section_separators = { left = nil, right = nil },
			always_divide_middle = false,
		},
		sections = {
			lualine_a = { block },
			lualine_b = { project },
			lualine_c = { filename },
			lualine_x = {
				"diagnostics",
				multicursor,
				macro,
				"location",
			},
			lualine_y = {},
			lualine_z = { block },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	},
}
