vim.keymap.set("n", "<leader><leader>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<leader>/", "<cmd>lua require('fzf-lua').live_grep_resume()<CR>", { silent = true })
vim.keymap.set("n", "<leader>,", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fr", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { silent = true })
vim.keymap.set("n", "<leader>[", "<cmd>lua require('fzf-lua')<CR>", { silent = true })
vim.keymap.set("n", "L", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", { silent = true })

return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- "fzf-native",
            winopts = {
                preview = {
                    -- delay = 0,
                    -- preview_pos = "right",
                    hidden = "hidden",
                    layout = "horizontal",
                    horizontal = "right:50%",
                },
                split = "bo 10split new",
            },
            defaults = {
                git_icons = false,
                file_icons = false,
                fzf_opts = {
                    ["--info"] = "inline-right",
                    -- ["--header-lines"] = 0,
                    -- ["--header-first"] = false,
                    -- ["--no-preview"] = "",
                },
            },
            files = {
                fzf_opts = {
                    ["--header"] = false,
                }
            },
        },
    },
}
