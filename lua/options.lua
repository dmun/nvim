local o = vim.o

o.sd = o.sd .. ",f1000"
o.ttimeout = false
o.ttimeoutlen = 0
o.lcs = "tab:  "
o.list = true
o.nu = true
o.rnu = true
o.so = 0
o.gcr = "a:Cursor-block"
o.cul = true
o.culopt = "number"
o.sms = true
o.shm = "IcFsCW"
o.winborder = "single"
-- o.wop = "fuzzy"
o.cot = "menuone"
o.scl = "no"
o.swf = false
o.ignorecase = true
o.scs = true
o.undofile = true
o.et = true
o.ts = 4
o.sw = 4
o.siso = 4
o.si = true
o.smd = false
o.ru = false
o.sc = false
o.ph = 6
o.wrap = false
o.spk = "screen"
-- o.fcs = "eob: "
o.acd = true
o.bri = true
o.ch = 0
o.stc = [[%!v:lua.require'util.statuscolumn'.init()]]

vim.diagnostic.config({
  signs = false,
})
