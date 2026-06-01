local au = vim.api.nvim_create_autocmd
local o = vim.o

-- Global
vim.g["sneak#s_next"] = 1
vim.g["sneak#use_ic_scs"] = 1

vim.g.python_host_prog = "/usr/bin/python2"
vim.g.python3_host_prog = "/usr/bin/python3"

-- Theme
vim.cmd.color("retrobox")

-- UI
o.breakindent = true
o.cmdheight = 1
o.cursorlineopt = "number"
o.cursorline = true
o.fillchars = "eob: "
o.guicursor = "a:Cursor-block"
o.listchars = "tab:⇥ "
o.list = true
o.number = true
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
o.linebreak = true

o.virtualedit = "onemore"
vim.cmd("autocmd InsertLeave * :normal! `^")

vim.ui.select = require("plugins.picker").ui_select

-- Autocomplete
o.autocomplete = false
o.completeopt = "fuzzy,menuone,noselect,popup"
o.pumheight = 6
o.pummaxwidth = 80

-- Other
o.grepprg = "rg --vimgrep --smart-case"
o.shada = o.shada .. ",f1000"
o.ttimeoutlen = 0
o.swapfile = false
o.ignorecase = true
o.smartcase = true
o.undofile = true
o.expandtab = true
o.tabstop = 8
o.shiftwidth = 8
o.smartindent = true
o.autochdir = true
o.clipboard = "unnamedplus"

-- Lsp
vim.diagnostic.config({ signs = false })
vim.highlight.priorities.semantic_tokens = 95
