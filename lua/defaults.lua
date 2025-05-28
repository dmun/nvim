local map, o = vim.keymap.set, vim.o

vim.g.mapleader = " "
vim.g.maplocalleader = " m"

o.ttimeout = false
o.ttimeoutlen = 0
o.lcs = "tab:  "
o.list = true
o.nu = true
o.rnu = true
o.so = 5
o.gcr = "a:Cursor-block"
o.cul = false
o.culopt = "both"
o.sms = true
o.shm = "IcFsSCW"
o.winborder = "double"
o.cot = "menuone"
o.scl = "no"
o.swf = false
o.scs = true
o.ignorecase = true
o.undofile = true
o.ts = 4
o.siso = 4
o.si = true
o.smd = false
o.ru = false
o.sc = false
o.ph = 6
o.wrap = false
o.spk = "screen"
o.fcs = "eob: "
o.acd = true
o.bri = true
o.ch = 1
o.stc = [[%!v:lua.require'util.statuscolumn'.init()]]

map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

map({ "n", "x" }, "gp", '"+p')
map({ "n", "x" }, "gy", '"+y')
nmap("u", "<Cmd>silent u<CR>")
nmap("<C-r>", "<Cmd>silent red<CR>")

nmap("<Leader>tw", function() o.wrap = not o.wrap end)

nmap("<Esc>", function()
  vim.cmd.nohl()
  vim.cmd.echo()
end)

-- nmap("<C-n>", "<Cmd>cnext<CR>")
-- nmap("<C-p>", "<Cmd>cprev<CR>")

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
