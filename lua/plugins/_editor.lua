return {
    {
        "nvim-neorg/neorg",
        ft = "norg",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {
                    config = {
                        folds = false,
                        icon_preset = "diamond",
                    },
                },                  -- Adds pretty icons to your documents
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
                ["core.esupports.metagen"] = {},
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
            },
        },
        build = ":Neorg sync-parsers",
    },
}
