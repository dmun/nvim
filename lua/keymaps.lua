vim.g.mapleader = " "
vim.g.maplocalleader = " m"

vim.o.langmap = "qb,bq,QB,BQ"
vim.o.langremap = true
vim.o.virtualedit = "onemore"

imap("<Esc>", function()
  local keys = vim.fn.col(".") ~= 1 and "l" or ""
  vim.fn.feedkeys(keys)
end)

local jump = require("util.jump").jump
map("s", bind(jump, false, 2))
map("S", bind(jump, true, 2))

nmap("f", bind(jump, false, 1))
nmap("F", bind(jump, true, 1))
xmap("f", bind(jump, false, 1))
xmap("F", bind(jump, true, 1))
omap("f", bind(jump, false, 1, false, true))
omap("F", bind(jump, true, 1, false, true))

nmap("t", bind(jump, false, 1, true))
nmap("T", bind(jump, true, 1, true))
xmap("t", bind(jump, false, 1, true))
xmap("T", bind(jump, true, 1, true))
omap("t", bind(jump, false, 1, true, true))
omap("T", bind(jump, true, 1, true, true))

nmap("gq",    cmd.copen)
nmap("<C-n>", cmd.cnext)
nmap("<C-p>", cmd.cprev)

map("H", "^")
map("L", "$")
map("M", "%")

nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

nmap("n", "nzz")
nmap("N", "Nzz")

map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

map({ "n", "x" }, "<Leader>p", '"+p')
map({ "n", "x" }, "<Leader>y", '"+y')

nmap("gr<Space>", ":grep ")
nmap("u",         "<Cmd>silent u<CR>")
nmap("<C-r>",     "<Cmd>silent red<CR>")

nmap("<Leader>tw", function() vim.o.wrap = not vim.o.wrap end)

nmap("<Esc>", bind(cmd, "nohl | echo"))

nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

imap("<C-h>", "<Esc><C-w>h")
imap("<C-j>", "<Esc><C-w>j")
imap("<C-k>", "<Esc><C-w>k")
imap("<C-l>", "<Esc><C-w>l")

tmap("<C-h>", "<C-\\><C-n><C-w>h")
tmap("<C-j>", "<C-\\><C-n><C-w>j")
tmap("<C-k>", "<C-\\><C-n><C-w>k")
tmap("<C-l>", "<C-\\><C-n><C-w>l")
