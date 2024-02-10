" Vim settings
let R_assign = 0
let mapleader="\<Space>"
let maplocalleader="\<C-Space>"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set mouse=a
set number
set relativenumber
set nornu nonu
set nowrap
set lbr
set breakindent
set nocursorline
set showtabline=0
set scrolloff=5
set sidescrolloff=10
set noshowmode
set noshowcmd
set noswapfile
set clipboard=unnamedplus
set completeopt=menuone,noselect
set signcolumn=yes
set inccommand=split
set lazyredraw
set termguicolors
set t_Co=256
set autochdir
" set cmdheight=0
" set laststatus=3
set shm+=I
let g:rooter_silent_chdir = 1
set splitkeep=topline
set splitbelow
set conceallevel=3
set nottimeout
set foldcolumn=0
set foldlevel=99
set foldlevelstart=99
set foldenable
set noshowmode
set noruler
set ignorecase
set smartcase
let g:sneak#use_ic_scs = 1

" autocmd! FileType Trouble,NeogitPopup
" autocmd FileType Trouble,NeogitPopup set laststatus=0 noshowmode noruler 
"     \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" let &stc='%=%{v:relnum?v:relnum:v:lnum} '
set guifont=Iosevka\ Term,Symbols\ Nerd\ Font:h19
" set fillchars+=vert:▕
set fillchars+=vert:▏
" set fillchars+=eob:\ 
let g:tex_flavor = "latex"

" Color settings
" syntax on
set termguicolors
set background=dark

" Readline
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$
inoremap <C-f> <C-o>l
inoremap <C-b> <C-o>h
inoremap <C-d> <C-o>x
inoremap <C-k> <C-o>D
inoremap <C-u> <C-o>dd
inoremap <M-d> <C-o>dw
inoremap <M-f> <C-o>w
inoremap <M-b> <C-o>b

nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
nnoremap <expr> 0 &wrap ? 'g0' : '0'
nnoremap <expr> $ &wrap ? 'g$' : '$'
" nnoremap Y y$

nnoremap <silent><leader>tw :set wrap!<CR>

set sol
" nnoremap <silent><C-d> <C-d>zz<CR>
" nnoremap <silent><C-u> <C-u>zz<CR>

" Save
" nnoremap <silent><C-s> :w!<CR><C-l>
" inoremap <silent><C-s> <C-o>:w!<CR><C-o><C-l>

" Clear
" nnoremap <silent><C-l> <C-l>:nohl<CR>
nnoremap <silent><ESC> <CMD>echo <Bar> nohl<CR>

" Navigating buffers
" nnoremap <silent><leader>bn :bnext<CR>
" nnoremap <silent><leader>bp :bprev<CR>
" nnoremap <silent><leader>sd :bd<CR>

" Run code
nnoremap <silent><A-r> :!make -s run<CR>
" nnoremap <silent><leader>ff :Ex<CR>

" augroup CursorLine
"     au!
"     au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"     au WinLeave * setlocal nocursorline
"     au FileType TelescopePrompt* setlocal nocursorline
" augroup END

" au CmdlineChanged * 
