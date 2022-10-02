require("lualine").setup({
    options = {
        theme = "modus-vivendi",
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
		disabled_filetypes = { "NvimTree", "neo-tree", "startify", "nofile" },
		always_divide_middle = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
	extensions = { "nvim-tree" },
})
