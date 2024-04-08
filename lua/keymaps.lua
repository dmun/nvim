-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " m"

vim.keymap.set("i", "<C-n>", "<cmd>norm j<cr>")
vim.keymap.set("i", "<C-p>", "<cmd>norm k<cr>")
vim.keymap.set("i", "<C-k>", "<cmd>norm dd<cr>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
