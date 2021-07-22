local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

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

local get_filename = function()
	return vim.fn.expand("%:h:t") .. "/" .. vim.fn.expand("%:t")
end

local file_readonly = function(readonly_icon)
	if vim.bo.filetype == "help" then
		return ""
	end
	local icon = readonly_icon or ""
	if vim.bo.readonly == true then
		return " " .. icon .. " "
	end
	return ""
end

local current_file_name_provider = function()
	local file = get_filename()
	if vim.fn.empty(file) == 1 then
		return ""
	end
	if string.len(file_readonly()) ~= 0 then
		return file .. file_readonly()
	end
	local icon = ""
	if vim.bo.modifiable then
		if vim.bo.modified then
			return file .. " " .. icon .. " "
		end
	end
	return file .. " "
end

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
			return '▊ '
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
		-- provider = current_file_name_provider,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_not_empty,
		highlight = {colors.fg,colors.bg,'bold'}
	}
}

gls.left[6] = {
	LineInfo = {
		provider = 'LineColumn',
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
		highlight = {colors.fg_inactive,colors.bg,'bold'},
	}
}

gls.left[8] = {
	DiagnosticError = {
		provider = 'DiagnosticError',
		icon = '  ',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.red,colors.bg}
	}
}
gls.left[9] = {
	DiagnosticWarn = {
		provider = 'DiagnosticWarn',
		icon = '  ',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.yellow,colors.bg},
	}
}

gls.left[10] = {
	DiagnosticHint = {
		provider = 'DiagnosticHint',
		icon = '  ',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.cyan,colors.bg},
	}
}

gls.left[11] = {
	DiagnosticInfo = {
		provider = 'DiagnosticInfo',
		icon = '  ',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.blue,colors.bg},
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
		condition = condition.check_git_workspace,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.green,colors.bg},
	}
}

gls.right[4] = {
	GitBranch = {
		provider = 'GitBranch',
		condition = condition.check_git_workspace,
		highlight = {colors.green,colors.bg},
	}
}

gls.right[8] = {
	BufferType = {
		provider = 'FileTypeName',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.fg,colors.bg,'bold'}
	}
}

gls.right[9] = {
	RainbowRed = {
		provider = function() return ' ' end,
		highlight = {colors.blue,colors.bg}
	},
}

-- gls.short_line_left[1] = {
-- 	RainbowRed = {
-- 		provider = function() return ' ' end,
-- 		highlight = {colors.blue,colors.bg}
-- 	},
-- }
-- gls.short_line_left[2] = {
-- 	BufferType = {
-- 		provider = 'FileTypeName',
-- 		separator = ' ',
-- 		separator_highlight = {'NONE',colors.bg},
-- 		highlight = {colors.blue,colors.bg,'bold'}
-- 	}
-- }
--
-- gls.short_line_left[3] = {
-- 	SFileName = {
-- 		provider = 'SFileName',
-- 		condition = condition.buffer_not_empty,
-- 		highlight = {colors.fg,colors.bg,'bold'}
-- 	}
-- }

gls.short_line_left[1] = {
	ViModeInactive = {
		provider = function() return '▊ ' end,
		highlight = {colors.fg_inactive,colors.bg,'bold'},
	},
}

gls.short_line_left[2] = {
	FileSizeInactive = {
		provider = 'FileSize',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_not_empty,
		highlight = {colors.fg_inactive,colors.bg}
	}
}

gls.short_line_left[3] = {
	FileNameInactive = {
		provider = 'FileName',
		-- provider = current_file_name_provider,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		condition = condition.buffer_not_empty,
		highlight = {colors.fg_inactive,colors.bg,'bold'}
	}
}
