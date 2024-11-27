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
		return vim.fs.basename(path)
	end,
	color = { fg = "#D7DBDF", gui = "bold" },
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
		local fg = "#cccccc"
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
			theme = "material",
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
