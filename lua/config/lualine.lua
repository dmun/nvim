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

local function get_inactive(component)
    local inactive = {}
    for key, value in pairs(component) do
        if key == 'inactive_color' then
            inactive['color'] = value
        elseif key ~= 'color' then
            inactive[key] = value
        end
    end
    return inactive
end

local function ins_left(component)
    table.insert(config.sections.lualine_a, component)
    table.insert(config.inactive_sections.lualine_a, get_inactive(component))
end

local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
    table.insert(config.inactive_sections.lualine_x, get_inactive(component))
end

-- Left components
ins_left {
    function()
        return '▍'
    end,
    color = { fg = colors.blue },
    inactive_color = { fg = colors.fg },
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
    function()
        local size = vim.fn.wordcount().bytes
        local suffixes = { '', 'k', 'm', 'g' }
        local i = 1
        while size > 1024 and i < #suffixes do
            size = size / 1024
            i = i + 1
        end
        if size / 10 >= 1 or i == 1 then
            return string.format('%d%s', size, suffixes[i])
        else
            return string.format('%.1f%s', size, suffixes[i])
        end
    end,
}

ins_left {
    function()
        local file = vim.fn.expand('%:t')
        return vim.fn.empty(file) == 1 and ''
            or vim.bo.modified and ''
            or vim.bo.readonly and ''
            or ''
    end,
    color = function()
        local file = vim.fn.expand('%:t')
        return {
            gui = 'bold',
            fg = vim.fn.empty(file) == 1 and colors.fg
              or vim.bo.modified and colors.red
              or vim.bo.readonly and colors.orange
              or colors.fg
        }
    end,
    padding = { left = 1, right = 0 }
}

ins_left {
    function()
        local file = vim.fn.expand('%:t')
        return vim.fn.empty(file) == 1 and '*new*' or file
    end,
    color = function()
        local file = vim.fn.expand('%:t')
        return {
            gui = 'bold',
            fg = vim.fn.empty(file) == 1 and colors.fg
              or vim.bo.modified and colors.red
              or colors.fg
        }
    end
}

ins_left {
    function()
        return '%l:%v'
    end,
}

ins_left {
    function()
        return '%p%%'
    end,
}

-- Right components
ins_right {
    function()
        return '$'
    end,
    color = { fg = colors.bg },
    inactive_color = { fg = colors.bg },
}

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
