" Vim settings
" let mapleader="\<Space>"
" let maplocalleader="\<Space>m"

autocmd! FileType fzf,NeogitPopup,Trouble
autocmd FileType fzf,NeogitPopup,Trouble set laststatus=0
    \| autocmd BufLeave <buffer> set laststatus=2

set guifont=Iosevka\ Term,Symbols\ Nerd\ Font:h19
" set fillchars+=vert:▕
set fillchars+=vert:▏
set fillchars+=eob:\ 
let g:tex_flavor = "latex"

" Color settings
" syntax on
set termguicolors
set background=dark

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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
