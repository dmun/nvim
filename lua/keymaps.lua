vim.g.mapleader = " "
vim.g.maplocalleader = "m"

nmap("<Leader>m", "m")

nmap("<Leader>i", cmd.Inspect)

require("util.jump")
nmap("s", bind(Patrick.jump, 2, false))
nmap("S", bind(Patrick.jump, 2, true))
xmap("s", bind(Patrick.jump, 2, false))
xmap("S", bind(Patrick.jump, 2, true))
omap("s", Patrick.jump_op(2, false, true))
omap("S", Patrick.jump_op(2, true, true))

nmap("f", bind(Patrick.jump, 1, false))
nmap("F", bind(Patrick.jump, 1, true))
xmap("f", bind(Patrick.jump, 1, false))
xmap("F", bind(Patrick.jump, 1, true))
omap("f", Patrick.jump_op(1, false))
omap("F", Patrick.jump_op(1, true))

nmap("t", bind(Patrick.jump, 1, false, true))
nmap("T", bind(Patrick.jump, 1, true, true))
xmap("t", bind(Patrick.jump, 1, false, true))
xmap("T", bind(Patrick.jump, 1, true, true))
omap("t", Patrick.jump_op(1, false, true))
omap("T", Patrick.jump_op(1, true, true))

nmap("<C-t>",    cmd.copen)
nmap("<M-n>", cmd.cnext)
nmap("<M-p>", cmd.cprev)

nmap("<M-o>", "<Cmd>!open .<CR>")

map("H", "^")
map("L", "$")
map("M",  "%")

nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

nmap("n", "nzz")
nmap("N", "Nzz")

map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

map({ "n", "x" }, "<Leader>p", '"+p')
map({ "n", "x" }, "<Leader>y", '"+y')

nmap("gr<Space>", ":grep ")

nmap("<Leader>tw", function() vim.o.wrap = not vim.o.wrap end)

nmap("<Esc>", bind(cmd, "nohl | echo"))

nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

-- imap("<C-h>", "<Esc><C-w>h")
-- imap("<C-j>", "<Esc><C-w>j")
-- imap("<C-k>", "<Esc><C-w>k")
-- imap("<C-l>", "<Esc><C-w>l")

tmap("<C-h>", "<C-\\><C-n><C-w>h")
tmap("<C-j>", "<C-\\><C-n><C-w>j")
tmap("<C-k>", "<C-\\><C-n><C-w>k")
tmap("<C-l>", "<C-\\><C-n><C-w>l")
