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
	color = { gui = "bold" },
}

local filename = {
	function()
		local ft = vim.bo.filetype
		local bt = vim.bo.buftype
		local path = vim.fn.expand("%:.")

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
			theme = "auto",
			component_separators = { left = nil, right = nil },
			section_separators = { left = nil, right = nil },
			always_divide_middle = false,
		},
		sections = {
			lualine_a = { mode },
			lualine_b = { project },
			lualine_c = { filename, "diagnostics" },
			lualine_x = { multicursor },
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = { mode },
			lualine_b = { project },
			lualine_c = { filename, "diagnostics" },
			lualine_x = { multicursor },
			lualine_y = {},
			lualine_z = {},
		},
	},
}
