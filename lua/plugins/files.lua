vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { silent = true })
vim.keymap.set("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { silent = true })
vim.keymap.set("n", "<leader>1", function() require('harpoon.ui').nav_file(1) end, { silent = true })
vim.keymap.set("n", "<leader>2", function() require('harpoon.ui').nav_file(2) end, { silent = true })
vim.keymap.set("n", "<leader>3", function() require('harpoon.ui').nav_file(3) end, { silent = true })
vim.keymap.set("n", "<leader>4", function() require('harpoon.ui').nav_file(4) end, { silent = true })

return {
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "ThePrimeagen/harpoon",
        lazy = true,
    },
}
