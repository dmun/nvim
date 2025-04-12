local o = vim.opt
local g = vim.g

-- globals
g.tex_flavor = "latex"

-- text
o.wrap = false
o.breakindent = true
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
o.relativenumber = true
o.signcolumn = "no"

-- appearance
o.background = "dark"
o.conceallevel = 2
o.lazyredraw = false
o.cursorline = true
o.cursorlineopt = "number"
o.ruler = false
o.showcmd = false
o.showmode = false
o.showtabline = 0
o.termguicolors = true
o.shm:append("I")
o.cmdheight = 1
o.pumheight = 8
-- o.colorcolumn = "+1"
o.fillchars = "eob: ,fold: ,foldopen:,foldclose:,foldsep: "
-- o.guicursor = "i:iCursor-block,n-v:nCursor-block"
-- o.guicursor = "i:Cursor-ver25-blinkon500-blinkoff500,n-v:rCursor-block"
o.guicursor = "a:Cursor-block"
o.laststatus = 2
o.list = true
o.listchars = "tab:  "

-- window
o.inccommand = "split"
o.splitbelow = true
o.splitright = true
o.splitkeep = "screen"
o.equalalways = false

-- keys
o.ignorecase = true
o.ttimeout = false
o.timeout = false
o.ttimeoutlen = 0
o.timeoutlen = 0
o.scrolloff = 5
o.sidescrolloff = 15
o.smartcase = true

-- file
o.swapfile = false
o.undofile = true

-- system
-- opt.autochdir = true
o.clipboard = "unnamedplus"

-- lazyvim statuscolumn
-- vim.opt.statuscolumn = [[%!v:lua.require'util.ui'.statuscolumn()]]
-- vim.opt.foldtext = "v:lua.require'util.ui'.foldtext()"

-- lsp
vim.highlight.priorities.semantic_tokens = 100
vim.diagnostic.config({ signs = false })
