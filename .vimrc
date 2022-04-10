" Vim settings
let mapleader=" "
let maplocalleader=","
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set mouse=a
set number
set relativenumber
set wrap
set lbr
set breakindent
set cursorline
set showtabline=0
" set scrolloff=5
set sidescrolloff=10
set noshowmode
set noshowcmd
set noswapfile
set clipboard=unnamedplus
set completeopt=menuone,noselect
set signcolumn=yes

set guifont=monospace,Symbols\ Nerd\ Font:h19
set fillchars+=vert:▕

" Color settings
syntax on
set termguicolors
set background=dark

nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
nnoremap <expr> 0 &wrap ? 'g0' : '0'
nnoremap <expr> $ &wrap ? 'g$' : '$'
nnoremap Y y$

nnoremap <silent><leader>tw :set wrap!<CR>

" Save
nnoremap <silent><C-s> :w!<CR><C-l>
inoremap <silent><C-s> <C-o>:w!<CR><C-o><C-l>

" Clear
nnoremap <silent><C-l> <C-l>:nohl<CR>
nnoremap <silent><ESC> <C-l>:nohl<CR>

" Navigating buffers
nnoremap <silent><M-n> :bnext<CR>
nnoremap <silent><M-p> :bprev<CR>
nnoremap <silent><M-w> :bd<CR>

" Split/close window
noremap <silent><M-v> <C-w>v
noremap <silent><M-s> <C-w>s
noremap <silent><M-q> <C-w>q
inoremap <silent><M-q> <ESC><C-w>q

" Navigating windows
nnoremap <silent><M-j> <C-w>j
nnoremap <silent><M-k> <C-w>k
nnoremap <silent><M-h> <C-w>h
nnoremap <silent><M-l> <C-w>l

tnoremap <silent><M-j> <C-\><C-n><C-w>j
tnoremap <silent><M-k> <C-\><C-n><C-w>k
tnoremap <silent><M-h> <C-\><C-n><C-w>h
tnoremap <silent><M-l> <C-\><C-n><C-w>l

" Moving windows
nnoremap <silent><M-r> <C-w>r
nnoremap <silent><M-J> <C-w>J
nnoremap <silent><M-H> <C-w>H
nnoremap <silent><M-K> <C-w>K
nnoremap <silent><M-L> <C-w>L

" Resizing windows
nnoremap <silent><M-C-j> :resize +3<CR>
nnoremap <silent><M-C-k> :resize -3<CR>
nnoremap <silent><M-C-h> :vertical resize -5<CR>
nnoremap <silent><M-C-l> :vertical resize +5<CR>

" Open terminal
nnoremap <silent><leader>t :term<CR>
autocmd TermOpen * startinsert | setlocal nonu nornu nocul scl=no
autocmd FocusGained,BufEnter,BufWinEnter,WinEnter term://* startinsert
