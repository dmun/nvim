local grapple = require("grapple")

vim.keymap.set("n", "<leader>q", grapple.toggle_tags)
vim.keymap.set("n", "<leader>m", grapple.tag)

vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>")
vim.keymap.set("n", "<leader>2", "<cmd>Grapple select index=2<cr>")
vim.keymap.set("n", "<leader>3", "<cmd>Grapple select index=3<cr>")
vim.keymap.set("n", "<leader>4", "<cmd>Grapple select index=4<cr>")
vim.keymap.set("n", "<leader>5", "<cmd>Grapple select index=5<cr>")
