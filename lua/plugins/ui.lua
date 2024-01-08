-- vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", function()
    require("neo-tree.command").execute({ toggle = true })
end, { silent = true })

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
                    TroubleText = {},
                    TroubleCount = { fg = colors.green },
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
                disabled_filetypes = { "NvimTree", "neo-tree", "startify", "nofile" },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
    {
        "j-hui/fidget.nvim",
        lazy = true,
        opts = {},
    },
    "norcalli/nvim-colorizer.lua",
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            enable_git_status = true,
            default_component_configs = {
                indent = {
                    with_markers = false,
                },
                icon = {
                    -- folder_closed = "",
                    -- folder_open = "",
                    default = "󰦨",
                    -- highlight = "NeoTreeNormal",
                },
                name = {
                    trailing_slash = true,
                    use_git_status_colors = true,
                },
                git_status = {
                    symbols = {
                        added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted = "", -- this can only be used in the git_status source
                        renamed = "", -- this can only be used in the git_status source
                        untracked = "",
                        ignored = "",
                        unstaged = "",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            window = {
                mappings = {
                    ["<Tab>"] = "toggle_node",
                    -- ["<CR>"] = "set_root",
                },
            },
        },
    },
}
