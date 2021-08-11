local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer','startify'}

--colors.fg = '#d4d4d4'
--colors.bg = '#2d2d2d'

colors.fg = '#BBC2CF'
colors.bg = '#21242B'
colors.fg_inactive = '#5B6268'

colors.red = '#ff6c6b'
colors.orange = '#da8548'
colors.green = '#98be65'
colors.yellow = '#ECBE7B'
colors.blue = '#51afef'
colors.dark_blue = '#2257A0'
colors.magenta = '#c678dd'

gls.left[1] = {
	LineActive = {
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
			return '   '
		end,
		condition = condition.buffer_not_empty,
		highlight = {colors.red,colors.bg,'bold'},
	},
}

gls.left[5] = {
	FileName = {
		provider = 'FileName',
		-- provider = current_file_name_provider,
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
		highlight = {colors.fg_inactive,colors.bg},
	},
}

gls.left[7] = {
	PerCent = {
		provider = 'LinePercent',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.fg_inactive,colors.bg},
	}
}

gls.right[1] = {
	FileEncode = {
		provider = 'FileEncode',
		condition = condition.hide_in_width,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.fg_inactive,colors.bg}
	}
}

gls.right[2] = {
	FileFormat = {
		provider = 'FileFormat',
		condition = condition.hide_in_width,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.fg_inactive,colors.bg}
	}
}

gls.right[3] = {
	GitIcon = {
		provider = function() return '  ' end,
		condition = condition.check_git_workspace and condition.hide_in_width,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.green,colors.bg},
	}
}

gls.right[4] = {
	GitBranch = {
		provider = 'GitBranch',
		condition = condition.check_git_workspace and condition.hide_in_width,
		highlight = {colors.green,colors.bg},
	}
}

gls.right[8] = {
	BufferType = {
		provider = 'FileTypeName',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_not_empty and condition.hide_in_width,
		highlight = {colors.fg,colors.bg,'bold'}
	}
}

gls.right[9] = {
	WhiteSpace = {
		provider = function() return ' ' end,
		condition = condition.buffer_not_empty and condition.hide_in_width,
		highlight = {colors.blue,colors.bg}
	},
}

function condition.buffer_types()
	local types = { 'NvimTree', 'startify', 'Gitty' }
	for _,v in ipairs(types) do
		if vim.bo.filetype == v then
			return false
		end
	end

	return true
end

gls.short_line_left[1] = {
	LineInactive = {
		provider = function() return '▍ ' end,
		condition = condition.buffer_types,
		highlight = {colors.fg_inactive,colors.bg,'bold'},
	},
}

gls.short_line_left[2] = {
	ViModeInactive = {
		provider = function() return '   ' end,
		condition = condition.buffer_types,
		highlight = {colors.fg_inactive,colors.bg,'bold'},
	},
}

gls.short_line_left[4] = {
	FileNameInactive = {
		provider = 'FileName',
		-- provider = current_file_name_provider,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_types,
		highlight = {colors.fg_inactive,colors.bg}
	}
}
