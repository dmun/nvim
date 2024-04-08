local opt = vim.opt

-- text
opt.wrap = false
opt.breakindent = true
opt.completeopt = "menuone,noselect"
opt.confirm = true
opt.expandtab = true
opt.linebreak = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.textwidth = 80

-- mouse
opt.mouse = "a"

-- statuscolumn
opt.foldcolumn = "0"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- appearance
opt.background = "dark"
opt.conceallevel = 3
opt.laststatus = 2
opt.lazyredraw = true
opt.cursorline = true
-- opt.cursorlineopt = "number"
opt.ruler = false
opt.showcmd = false
opt.showmode = false
opt.showtabline = 0
opt.termguicolors = true
opt.shm:append("I")

-- window
opt.inccommand = "split"
opt.splitbelow = true
opt.splitkeep = "topline"

-- keys
opt.ignorecase = true
opt.ttimeout = false
opt.scrolloff = 5
opt.sidescrolloff = 10
opt.smartcase = true

-- file
opt.swapfile = false
opt.undofile = true

-- system
-- opt.autochdir = true
opt.clipboard = "unnamedplus"
