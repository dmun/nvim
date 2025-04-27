local map = vim.keymap.set
local util = require("util")

map("n", "<Esc>", function()
  vim.cmd.noh()
  vim.cmd.echo()
end, { silent = true })

map("n", "<leader>q", vim.cmd.copen, { silent = true })
map("n", "<M-o>", "<cmd>!open .<cr><cr>", { silent = true })

map("n", "<leader>tw", "<cmd>set wrap!<cr>")
map("n", "<leader>tl", "<cmd>set list!<cr>")
map("n", "<leader>dl", "<cmd>messages<cr>")
map("n", "<C-,>", "gccj")

map("n", "<LocalLeader>r", util.run_command)
map("n", "<LocalLeader>R", util.run_command_reset)

map("i", "<C-n>", "<Down>")
map("i", "<C-p>", "<Up>")
map("i", "<C-_>", "<C-o>u")

map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })

map("n", "yc", "yygccp")
map("n", "<leader>p", "<cmd>Lazy<cr>")
map("x", "<C-,>", "gc")

map({ "n", "x" }, "<M-h>", "<C-w>h")
map({ "n", "x" }, "<M-j>", "<C-w>j")
map({ "n", "x" }, "<M-k>", "<C-w>k")
map({ "n", "x" }, "<M-l>", "<C-w>l")

map("i", "<M-h>", "<Esc><C-w>h")
map("i", "<M-j>", "<Esc><C-w>j")
map("i", "<M-k>", "<Esc><C-w>k")
map("i", "<M-l>", "<Esc><C-w>l")

map("t", "<M-h>", "<C-\\><C-n><C-w>h")
map("t", "<M-j>", "<C-\\><C-n><C-w>j")
map("t", "<M-k>", "<C-\\><C-n><C-w>k")
map("t", "<M-l>", "<C-\\><C-n><C-w>l")
