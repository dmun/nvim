local o = vim.opt
local g = vim.g

-- globals
g.tex_flavor = 'latex'
g.rooter_silent_chdir = 1
g['sneak#use_ic_scs'] = 1

-- text
o.wrap = false
o.breakindent = true
o.completeopt = 'menuone,noselect'
o.confirm = true
o.expandtab = false
o.linebreak = true
o.softtabstop = -1
o.tabstop = 4
o.shiftwidth = 0
o.textwidth = 0

-- mouse
o.mouse = 'a'

-- statuscolumn
o.foldcolumn = '0'
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
o.number = true
o.relativenumber = false
o.signcolumn = 'yes'

-- appearance
o.background = 'dark'
o.conceallevel = 2
o.lazyredraw = false
o.cursorline = true
o.cursorlineopt = 'number'
o.ruler = false
o.showcmd = false
o.showmode = false
o.showtabline = 0
o.termguicolors = true
o.shm:append('I')
o.cmdheight = 0
o.pumheight = 10
-- o.colorcolumn = "+1"
o.fillchars = 'eob: '
o.guicursor = "i:iCursor-block,n-v:Cursor-block"
-- o.guicursor = 'i:Cursor-ver25'
-- o.guicursor = 'a:Cursor-block'
-- o.laststatus = 0

-- window
o.inccommand = 'split'
o.splitbelow = true
o.splitkeep = 'screen'

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
o.clipboard = 'unnamedplus'

-- lazyvim statuscolumn
vim.opt.statuscolumn = [[%!v:lua.require'util.ui'.statuscolumn()]]
vim.opt.foldtext = "v:lua.require'util.ui'.foldtext()"

-- diagnostics
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.HINT] = '',
			[vim.diagnostic.severity.INFO] = '',
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = 'DiagnosticSignLineError',
			[vim.diagnostic.severity.WARN] = 'DiagnosticSignLineWarn',
		},
	},
})
