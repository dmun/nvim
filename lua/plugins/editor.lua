return {
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("illuminate").configure({
                filetypes_denylist = {
                    "NeogitStatus",
                },
            })
        end,
    },
    "windwp/nvim-autopairs",
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").create_default_mappings()
        end,
    },
    {
        "nvim-neorg/neorg",
        ft = "norg",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                    },
                },
                ["core.keybinds"] = {
                    config = {
                        hook = function(keybinds)
                            -- keybinds.unmap("norg", "n", "<C-space>")
                            keybinds.remap_event(
                                "norg",
                                "n",
                                "<C-Space>",
                                "core.qol.todo_items.todo.task_cycle_reverse"
                            )
                        end,
                    },
                },
                ["core.autocommands"] = {},
                ["core.integrations.treesitter"] = {},
                ["core.esupports.indent"] = {},
            },
        },
        build = ":Neorg sync-parsers",
    },
    {
        "nacro90/numb.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
}
