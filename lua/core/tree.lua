vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })

require("neo-tree").setup {
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
              added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "",-- this can only be used in the git_status source
              renamed   = "",-- this can only be used in the git_status source
              untracked = "",
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            },
        },
    },
    window = {
        mappings = {
            ["<Tab>"] = "toggle_node",
            -- ["<CR>"] = "set_root",
        },
    },
}
