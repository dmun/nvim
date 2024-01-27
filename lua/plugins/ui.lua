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
                    -- Comment = { fg = colors.flamingo },
                    -- [] = { fg = colors.peach, style = {} },
                    -- ["@comment"] = { fg = colors.surface2, style = { "italic" } },
                    -- CursorLine = { bg = colors.base },
                    -- NeoTreeCursorLine = { bg = colors.surface0 },
                    -- EndOfBuffer = { fg = colors.surface0 },
                    NeoTreeEndOfBuffer = { fg = colors.base },
                    FzfLuaBorder = { fg = colors.blue },
                    -- FzfLuaHeaderBind = { fg = colors.blue },
                    FzfLuaHeaderText = { fg = colors.blue },
                    TroubleText = {},
                    TroubleCount = { fg = colors.green },
                    -- FzfLuaNormal = { bg = colors.mantle },
                    -- GitSignsAdd = { fg = "#4d6257" },
                    -- GitSignsAdd = { fg = "#8bbc8b" },
                    -- GitSignsChange = { fg = "#97bbfa" },
                    -- GitSignsDelete = { fg = "#c87591" },
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
                },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "mode", "filename" },
                lualine_x = { "progress", "location" },
                lualine_y = {},
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "mode", "filename" },
                lualine_x = { "progress", "location" },
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
    {
        "j-hui/fidget.nvim",
        lazy = true,
        opts = {},
    },
    "norcalli/nvim-colorizer.lua",
}
