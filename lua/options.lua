local o = vim.opt
local g = vim.g

-- globals
g.tex_flavor = "latex"
g.rooter_silent_chdir = 1
g["sneak#use_ic_scs"] = 1

-- text
o.wrap = false
o.breakindent = true
o.completeopt = "menuone,noselect"
o.confirm = true
o.expandtab = true
o.linebreak = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4
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
o.signcolumn = "yes"

-- appearance
o.background = "dark"
o.conceallevel = 2
o.laststatus = 2
o.lazyredraw = true
o.cursorline = true
o.cursorlineopt = "number"
o.ruler = false
o.showcmd = false
o.showmode = false
o.showtabline = 0
o.termguicolors = true
o.shm:append("I")
o.cmdheight = 1
o.pumheight = 15
-- o.colorcolumn = "+1"
o.fillchars = "eob: "
o.guicursor = "i:block,n:block"

-- window
o.inccommand = "split"
o.splitbelow = true
o.splitkeep = "screen"

-- keys
o.ignorecase = true
o.ttimeout = false
o.timeout = false
o.ttimeoutlen = 0
o.timeoutlen = 0
o.scrolloff = 5
o.sidescrolloff = 10
o.smartcase = true

-- file
o.swapfile = false
o.undofile = true

-- system
-- opt.autochdir = true
o.clipboard = "unnamedplus"

-- lazyvim statuscolumn
vim.opt.statuscolumn = [[%!v:lua.require'util.ui'.statuscolumn()]]
vim.opt.foldtext = "v:lua.require'util.ui'.foldtext()"

-- diagnostics
vim.diagnostic.config {
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignLineError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignLineWarn",
		},
	},
}
