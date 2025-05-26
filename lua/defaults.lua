local map, o = vim.keymap.set, vim.o

vim.g.mapleader = " "
vim.g.maplocalleader = " m"

o.ttimeout = false
o.ttimeoutlen = 0
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
map("n", "u", "<Cmd>silent u<CR>")
map("n", "<C-r>", "<Cmd>silent red<CR>")

map("n", "<Leader>tw", function() o.wrap = not o.wrap end)

map("n", "<Esc>", function()
  vim.cmd.nohl()
  vim.cmd.echo()
end)

-- map("n", "<C-n>", "<Cmd>cnext<CR>")
-- map("n", "<C-p>", "<Cmd>cprev<CR>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("i", "<C-h>", "<Esc><C-w>h")
map("i", "<C-j>", "<Esc><C-w>j")
map("i", "<C-k>", "<Esc><C-w>k")
map("i", "<C-l>", "<Esc><C-w>l")

map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")
