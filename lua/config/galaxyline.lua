-- vim:fdm=marker

local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer','startify'}
gl.hidden_list = {'NvimTree','startify'}

colors.fg = '#BBC2CF'
colors.bg = '#1D2026'
colors.fg_inactive = '#5B6268'
colors.bg_inactive = '#21242B'

colors.red = '#ff6c6b'
colors.orange = '#da8548'
colors.green = '#98be65'
colors.yellow = '#ECBE7B'
colors.blue = '#51afef'
colors.dark_blue = '#2257A0'
colors.magenta = '#c678dd'

function condition.hidden_types()
	for _,v in ipairs(gl.hidden_list) do
		if vim.bo.filetype == v then
			return false
		end
	end

	return true
end

-- Left {{{

gls.left[1] = {
	Line = {
		provider = function() return '▍ ' end,
		highlight = {colors.blue,colors.bg,'bold'},
	},
}

gls.left[2] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			local mode_color = {n = colors.green, i = colors.blue,v=colors.orange,
				[''] = colors.orange,V=colors.orange,
				c = colors.magenta,no = colors.red,s = colors.orange,
				S=colors.orange,[''] = colors.orange,
				ic = colors.yellow,R = colors.violet,Rv = colors.violet,
				cv = colors.red,ce=colors.red, r = colors.cyan,
				rm = colors.cyan, ['r?'] = colors.cyan,
				['!'] = colors.red,t = colors.red}
			vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
			return '●  '
		end,
		highlight = {colors.red,colors.bg,'bold'},
	},
}

gls.left[3] = {
	FileSize = {
		provider = 'FileSize',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_not_empty,
		highlight = {colors.fg,colors.bg}
	}
}

gls.left[5] = {
	FileName = {
		provider = 'FileName',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_not_empty,
		highlight = {colors.fg,colors.bg,'bold'}
	}
}

gls.left[6] = {
	LineInfo = {
		provider = function ()
			local line = vim.fn.line('.')
			local column = vim.fn.col('.')
			return line .. ':' .. column
		end,
		condition = condition.buffer_not_empty,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.fg,colors.bg},
	},
}

gls.left[7] = {
	Percent = {
		provider = 'LinePercent',
		condition = condition.buffer_not_empty,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.fg,colors.bg},
	}
}

-- }}}

-- Right {{{

gls.right[1] = {
	FileFormat = {
		provider = 'FileFormat',
		condition = condition.buffer_not_empty,
		highlight = {colors.fg,colors.bg}
	}
}

gls.right[2] = {
	WhiteSpace = {
		provider = function() return ' ' end,
		condition = condition.buffer_not_empty,
		highlight = {colors.fg,colors.bg}
	}
}

gls.right[3] = {
	FileEncode = {
		provider = 'FileEncode',
		condition = condition.buffer_not_empty,
		highlight = {colors.fg,colors.bg}
	}
}

gls.right[4] = {
	BufferType = {
		provider = function () return vim.bo.filetype end,
		separator = '  ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_not_empty,
		highlight = {colors.blue,colors.bg,'bold'}
	}
}

gls.right[5] = {
	GitIcon = {
	 	provider = function() return '' end,
		separator = '  ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_not_empty,
		highlight = {colors.green,colors.bg},
	}
}

gls.right[6] = {
	GitBranch = {
		provider = 'GitBranch',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_not_empty,
		highlight = {colors.green,colors.bg,'bold'},
	}
}

gls.right[7] = {
	WhiteSpace = {}
}

gls.right[8] = {
	LspActivity = {
		provider = function () return ' ' end,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		condition = function ()
			local buf_ft = vim.api.nvim_buf_get_option(0,'filetype')
			local clients = vim.lsp.get_active_clients()
			if next(clients) == nil then
				return false
			end
			for _,client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
					return true
				end
			end
			return false
		end,
		highlight = {colors.green,colors.bg,'bold'}
	}
}

-- }}}

-- Left Inactive {{{

gls.short_line_left[1] = {
	LineNC = {
		provider = function() return '▍ ' end,
		condition = condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive,'bold'},
	},
}

gls.short_line_left[2] = {
	ViModeNC = {
		provider = function()
			-- auto change color according the vim mode
			local mode_color = {n = colors.green, i = colors.blue,v=colors.orange,
				[''] = colors.orange,V=colors.orange,
				c = colors.magenta,no = colors.red,s = colors.orange,
				S=colors.orange,[''] = colors.orange,
				ic = colors.yellow,R = colors.violet,Rv = colors.violet,
				cv = colors.red,ce=colors.red, r = colors.cyan,
				rm = colors.cyan, ['r?'] = colors.cyan,
				['!'] = colors.red,t = colors.red}
			vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
			return '●  '
		end,
		condition = condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive,'bold'},
	},
}

gls.short_line_left[3] = {
	FileSizeNC = {
		provider = 'FileSize',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg_inactive},
		condition = condition.buffer_not_empty and condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive}
	}
}

gls.short_line_left[5] = {
	FileNameNC = {
		provider = 'FileName',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg_inactive},
		condition = condition.buffer_not_empty and condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive,'bold'}
	}
}

gls.short_line_left[6] = {
	LineInfoNC = {
		provider = function ()
			local line = vim.fn.line('.')
			local column = vim.fn.col('.')
			return line .. ':' .. column
		end,
		condition = condition.buffer_not_empty and condition.hidden_types,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg_inactive},
		highlight = {colors.fg_inactive,colors.bg_inactive},
	},
}

gls.short_line_left[7] = {
	PercentNC = {
		provider = 'LinePercent',
		condition = condition.buffer_not_empty and condition.hidden_types,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg_inactive},
		highlight = {colors.fg_inactive,colors.bg_inactive},
	}
}

-- }}}

-- Right Inactive {{{

gls.short_line_right[1] = {
	FileFormatNC = {
		provider = 'FileFormat',
		condition = condition.buffer_not_empty and condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive}
	}
}

gls.short_line_right[2] = {
	WhiteSpaceNC = {
		provider = function() return ' ' end,
		condition = condition.buffer_not_empty and condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive}
	}
}

gls.short_line_right[3] = {
	FileEncodeNC = {
		provider = 'FileEncode',
		condition = condition.buffer_not_empty and condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive}
	}
}

gls.short_line_right[4] = {
	BufferTypeNC = {
		provider = function () return vim.bo.filetype end,
		separator = '  ',
		separator_highlight = {'NONE',colors.bg_inactive},
		condition = condition.buffer_not_empty and condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive,'bold'}
	}
}

gls.short_line_right[5] = {
	GitIconNC = {
	 	provider = function() return '' end,
		separator = '  ',
		separator_highlight = {'NONE',colors.bg_inactive},
		condition = condition.buffer_not_empty and condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive},
	}
}

gls.short_line_right[6] = {
	GitBranchNC = {
		provider = 'GitBranch',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg_inactive},
		condition = condition.buffer_not_empty and condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive,'bold'},
	}
}

gls.short_line_right[7] = {
	WhiteSpaceNC = {}
}

gls.short_line_right[8] = {
	LspActivityNC = {
		provider = function () return ' ' end,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg_inactive},
		condition = function ()
			local buf_ft = vim.api.nvim_buf_get_option(0,'filetype')
			local clients = vim.lsp.get_active_clients()
			if next(clients) == nil then
				return false
			end
			for _,client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
					return true
				end
			end
			return false
		end and condition.hidden_types,
		highlight = {colors.fg_inactive,colors.bg_inactive,'bold'}
	}
}

-- }}}
