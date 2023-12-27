require('fzf-lua').setup({
    winopts = {
        preview = {
            -- delay = 0,
        }
    },
})

vim.keymap.set("n", "<leader><leader>", ":FzfLua files<CR>", { silent = true })
vim.keymap.set("n", "<leader>/", ":FzfLua live_grep_resume<CR>", { silent = true })
vim.keymap.set("n", "<leader>,", ":FzfLua buffers<CR>", { silent = true })
vim.keymap.set("n", "<leader>fr", ":FzfLua oldfiles<CR>", { silent = true })
vim.keymap.set("n", "L", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", { silent = true })
