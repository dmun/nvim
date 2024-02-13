return {
    {
        "catppuccin/nvim",
        -- enabled = false,
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
            custom_highlights = function(colors)
                return {
                    NeoTreeEndOfBuffer = { fg = colors.base },
                    -- FzfLuaBorder = { fg = colors.blue },
                    FzfLuaHeaderBind = { fg = colors.lavender },
                    FzfLuaHeaderText = { fg = colors.lavender },
                    -- FzfLuaNormal = { bg = colors.mantle },
                    -- TroubleText = {},
                    TroubleCount = { fg = colors.green },
                    -- CursorLine = { bg = colors.base },
                    CursorLine = { bg = "#2A2B3E" },
                    CursorLineNr = { bg = "#2A2B3E" },
                    CursorLineSign = { bg = "#2A2B3E" },
                    TreesitterContext = { bg = colors.surface0 },
                    TroubleText = { bg = colors.none },
                    TroubleFoldIcon = { bg = colors.none },
                    CursorInsert = { bg = colors.green },
                    Cursor = { bg = colors.rosewater },
                    ["@neorg.todo_items.pending"] = { style = { "altfont" } },
                    ["@neorg.todo_items.on_hold"] = { fg = colors.blue, bg = colors.none },
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
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                -- disabled_filetypes = {
                --     "NvimTree",
                --     "neo-tree",
                --     "startify",
                --     "nofile",
                --     "NeogitPopup",
                --     "DiffViewFiles",
                --     "fzf",
                --     "Trouble",
                -- },
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
    "norcalli/nvim-colorizer.lua",
}