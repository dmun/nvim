" globals
let g:tex_flavor="latex"

" text
se nowrap
se breakindent
se completeopt=menuone,noselect
se confirm
se noexpandtab
se linebreak
se softtabstop=-1
se tabstop=4
se shiftwidth=0
se textwidth=0

" mouse
se mouse=a

" statuscolumn
se foldcolumn=0
se foldenable
se foldlevel=99
se foldlevelstart=99
se nonumber
se numberwidth=4
se norelativenumber
se signcolumn=no

" appearance
se background=dark
se conceallevel=2
se nolazyredraw
se cursorline
se cursorlineopt=number
se noruler
se noshowcmd
se showmode
se showtabline=1
"se tabline=\ 
se termguicolors
se shm+=I
se cmdheight=1
se pumheight=6
" o.colorcolumn = "+1"
se fillchars=eob:\ ,fold:\ ,foldopen:,foldclose:,foldsep:\ 
" o.guicursor = "i:iCursor-block,n-v:nCursor-block"
"se guicursor=i:Cursor-block-blinkon500-blinkoff500,n-v:Cursor-block
se guicursor=a:Cursor-block
se laststatus=2
"se statusline=%t\ %m%{&modified?'':'\ \ \ '}\ %p%%\ (%l,\ %c)%=
se listchars=tab:»\ ,multispace:⸳
se nolist

" window
se inccommand=split
se splitbelow
se splitright
se splitkeep=screen
se equalalways
" o.messagesopt = ""

" keys
se ignorecase
se nottimeout
se notimeout
se ttimeoutlen=0
se timeoutlen=0
se scrolloff=0
se sidescrolloff=15
se smartcase

" file
se noswapfile
se undofile

" system
se autochdir
se clipboard=unnamedplus

se statuscolumn=%!v:lua.require'util.statuscolumn'.init()

" lsp
" vim.highlight.priorities.semantic_tokens = 100
"o.diagnostic.config({ signs = false })
