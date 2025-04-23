local o = vim.opt
local g = vim.g

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
o.number = false
o.numberwidth = 4
o.relativenumber = false
o.signcolumn = "no"

-- appearance
o.background = "dark"
o.conceallevel = 2
o.lazyredraw = false
o.cursorline = true
o.cursorlineopt = "number"
o.ruler = false
o.showcmd = false
o.showmode = true
o.showtabline = 1
o.termguicolors = true
o.shm:append("I")
o.cmdheight = 1
o.pumheight = 6
-- o.colorcolumn = "+1"
o.fillchars = "eob: ,fold: ,foldopen:,foldclose:,foldsep: "
-- o.guicursor = "i:iCursor-block,n-v:nCursor-block"
o.guicursor = "i:Cursor-block-blinkon500-blinkoff500,n-v:Cursor-block"
o.guicursor = "a:Cursor-block"
o.laststatus = 2
o.listchars = "tab:» ,multispace:⸳"
o.list = false

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
o.scrolloff = 0
o.sidescrolloff = 15
o.smartcase = true

-- file
o.swapfile = false
o.undofile = true

-- system
o.autochdir = true
o.clipboard = "unnamedplus"

-- lsp
vim.highlight.priorities.semantic_tokens = 100
vim.diagnostic.config({ signs = false })
