local o = vim.opt
local g = vim.g

vim.g.mapleader = " "
vim.g.maplocalleader = " m"

g.tex_flavor = "latex"

-- text
o.wrap = true
o.breakindent = true
-- o.breakat = " "
o.completeopt = "menuone,noselect"
o.confirm = true
o.expandtab = false
o.linebreak = true
o.softtabstop = -1
o.tabstop = 4
o.shiftwidth = 0
o.textwidth = 0

-- mouse
o.mouse = "a"

-- statuscolumn
o.foldcolumn = "0"
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
o.number = true
o.numberwidth = 4
o.relativenumber = true
o.signcolumn = "no"
o.statuscolumn = [[%!v:lua.require'util.statuscolumn'.init()]]

-- appearance
o.background = "dark"
o.conceallevel = 2
o.lazyredraw = false
o.cursorline = true
o.cursorlineopt = "number"
o.ruler = false
o.showcmd = false
o.showmode = false
o.showtabline = 1
o.termguicolors = true
o.shm:append("I")
o.cmdheight = 1
o.pumheight = 6
-- o.colorcolumn = "+1"
o.fillchars = "eob: ,fold: ,foldopen:,foldclose:,foldsep: ,diff: ,vert: "
-- o.guicursor = "i:iCursor-block,n-v:nCursor-block"
-- o.guicursor = "i:Cursor-ver25-blinkon500-blinkoff500,n-v:Cursor-block"
o.guicursor = "a:Cursor-block"
o.laststatus = 2
o.listchars = "tab:  ,multispace: "--⸳"
o.list = true
-- o.virtualedit = "all"
vim.o.winborder = "single"


-- window
o.inccommand = "split"
o.splitbelow = true
o.splitright = true
o.splitkeep = "screen"
o.equalalways = true
-- o.messagesopt = ""

-- keys
o.ignorecase = true
o.ttimeout = false
o.timeout = false
o.ttimeoutlen = 0
o.timeoutlen = 0
o.scrolloff = 5
o.sidescrolloff = 0
o.smartcase = true

-- file
o.swapfile = false
o.undofile = true

-- system
o.autochdir = true
o.clipboard = "unnamedplus"

-- lsp
vim.highlight.priorities.semantic_tokens = 95
vim.diagnostic.config({ signs = false })

-- PADDED = { "▀", "▀", "▀", " ", "▃", "▃", "▃", " " }
-- local hover = vim.lsp.buf.hover
-- local open_float = vim.diagnostic.open_float
-- vim.lsp.buf.hover = function() hover({ border = "double" }) end
-- vim.diagnostic.open_float = function() open_float({ border = "double" }) end
