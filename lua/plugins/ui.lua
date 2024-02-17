return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "mode", "filename" },
                lualine_x = {
                    "diagnostics",
                    {
                        "fileformat",
                        icons_enabled = false,
                    },
                    "progress",
                    "location",
                },
                lualine_y = {},
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    function()
                        return "      "
                    end,
                    "filename",
                },
                lualine_x = {
                    "diagnostics",
                    {
                        "fileformat",
                        icons_enabled = false,
                    },
                    "progress",
                    "location",
                },
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
}
