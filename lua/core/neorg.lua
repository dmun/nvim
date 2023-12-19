require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    -- keybinds.unmap("norg", "n", "<C-space>")
                    keybinds.remap_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.task_cycle_reverse")
                end,
            }
        },
        ["core.autocommands"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.esupports.indent"] = {},
        ["core.concealer"] = {},
    }
}

