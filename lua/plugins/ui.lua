return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
            custom_highlights = function(colors)
                return {
                    NeoTreeEndOfBuffer = { fg = colors.base },
                    FzfLuaBorder = { fg = colors.blue },
                    FzfLuaHeaderText = { fg = colors.blue },
                    TroubleText = {},
                    TroubleCount = { fg = colors.green },
                    CursorLine = { bg = colors.base },
                }
            end,
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                -- theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    "NvimTree",
                    "neo-tree",
                    "startify",
                    "nofile",
                    "NeogitPopup",
                    "DiffviewFiles",
                    "fzf",
                    "Trouble",
                },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "mode", "filename" },
                lualine_x = {
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
        lazy = false,
        opts = {},
    },
    "norcalli/nvim-colorizer.lua",
}
