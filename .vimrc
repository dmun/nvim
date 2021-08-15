" Vim settings
let mapleader=" "
set tabstop=4
set shiftwidth=4
set softtabstop=4
" set expandtab
set mouse=a
set number
set relativenumber
set nowrap
set cursorline
set showtabline=2
set scrolloff=5
set noshowmode
set completeopt=menuone,noinsert

set guifont=monospace,Symbols\ Nerd\ Font:h19
set fillchars+=vert:▕

" Color settings
syntax on
set termguicolors
colorscheme doom-one
set background=dark

" Navigating buffers
nnoremap <silent><M-n> :bnext<CR>
nnoremap <silent><M-p> :bprev<CR>
nnoremap <silent><M-w> :bd<CR>

" Split/close window
noremap <silent><M-v> <C-w>v
noremap <silent><M-s> <C-w>s
noremap <silent><M-q> <C-w>q

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
nnoremap <silent><leader>t :exec 'term' \| setlocal nonu nornu \| setlocal nocul<CR>
