local o = vim.o

-- Theme
vim.cmd.color("boomer")

-- UI
o.breakindent = true
o.cmdheight = 1
o.cursorlineopt = "number"
o.cursorline = true
o.fillchars = "eob: "
-- o.guicursor = "a:Cursor-block"
o.listchars = "tab:  "
o.list = true
o.number = true
o.pumheight = 6
o.relativenumber = true
o.ruler = false
o.scrolloff = 5
o.showcmd = false
o.shortmess = "IcFsCW"
o.showmode = false
o.sidescrolloff = 4
o.signcolumn = "no"
o.smoothscroll = true
o.splitkeep = "screen"
o.statuscolumn = "%!v:lua.require'util.statuscolumn'()"
o.statusline = " %f %m %r %= %l/%L  %c "
o.winborder = "single"
o.wrap = false

-- Other
o.grepprg = "rg --vimgrep --smart-case"
o.shada = o.shada .. ",f1000"
o.ttimeoutlen = 0
o.completeopt = "menuone"
o.swapfile = false
o.ignorecase = true
o.smartcase = true
o.undofile = true
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.autochdir = true

-- Lsp
vim.diagnostic.config({ signs = false })
vim.highlight.priorities.semantic_tokens = 95
