local colors = {
    fg = '#BBC2CF',
    bg = '#1D2026',
    blue = '#51AFEF',
    green = '#98BE65',
    orange = '#ECBE7B',
    red = '#FF6C6B',
    inactive = {
        fg = '#5B6268',
        bg = '#21242B',
    }
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h') local gitdir = vim.fn.finddir('.git', filepath .. ';') return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = {
  options = {
    icons_enabled = true,
    theme = {
        normal = {
            a = { fg = colors.fg, bg = colors.bg },
            c = { fg = colors.fg, bg = colors.bg },
            x = { fg = colors.fg, bg = colors.bg },
        },
        inactive = {
            a = { fg = colors.inactive.fg, bg = colors.inactive.bg },
            c = { fg = colors.inactive.fg, bg = colors.inactive.bg },
            x = { fg = colors.inactive.fg, bg = colors.inactive.bg },
        },
    },
    component_separators = { left = '', right = ''},
    --section_sep earators = { left = '', right = ''},
    disabled_filetypes = { 'NvimTree', 'startify'},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = { 'nvim-tree' }
}

local function ins_left(component)
    table.insert(config.sections.lualine_a, component)
    table.insert(config.inactive_sections.lualine_a, component)
end

local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
    table.insert(config.inactive_sections.lualine_x, component)
end

-- Left components
ins_left {
    function()
        return '▍'
    end,
    color = { fg = colors.blue },
    padding = { left = 0 },
}

ins_left {
    function()
        return '●'
    end,
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.green,
            i = colors.blue,
            v = colors.orange,
            [''] = colors.orange,
            V = colors.orange,
            R = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()], gui = 'bold' }
    end,
}

ins_left {
    'filesize',
    cond = conditions.buffer_not_empty,
}

ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { gui = 'bold' }
}

ins_left {
    'location',
}

-- Right components
ins_right {
    'bo:filetype',
    color = { fg = colors.blue, gui = 'bold' },
}

ins_right {
    'branch',
    icon = '',
    color = { fg = colors.green, gui = 'bold' },
}

require('lualine').setup(config)
