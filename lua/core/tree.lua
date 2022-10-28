vim.keymap.set("n", "<leader>e", ":NeoTreeFocusToggle<CR>", { silent = true })

require("neo-tree").setup {
    default_component_configs = {
        indent = {
            with_markers = false,
        },
        -- icon = {
        --     folder_closed = "",
        --     folder_open = "",
        -- },
        git_status = {
            symbols = {
                -- untracked = "",
            },
        },
    },
    window = {
        mappings = {
            ["<Tab>"] = "toggle_node",
        },
    },
}
