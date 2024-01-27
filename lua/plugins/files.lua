vim.keymap.set("n", "<M-c>", "<CMD>Oil<CR>", { silent = true })

return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
