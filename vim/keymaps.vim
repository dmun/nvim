let mapleader = " "
let maplocalleader = " m"

nnoremap <esc> <cmd>nohl \| echo ''<CR>
nnoremap <leader>q <cmd>copen<CR>
"nnoremap <C-t> <cmd>tabnew<cr>
nnoremap <silent> <M-o> <cmd>!open .<cr><cr>

xnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> <Up> v:count == 0 ? 'gk' : 'k'
xnoremap <expr> <Down> v:count == 0 ? 'gj' : 'j'
nnoremap <expr> <Up> v:count == 0 ? 'gk' : 'k'
nnoremap <expr> <Down> v:count == 0 ? 'gj' : 'j'

nnoremap <leader>tw :set wrap!<CR>
nnoremap <leader>tl :set list!<CR>
nnoremap <C-,> gccj
nnoremap <leader>dl :messages<CR>

nnoremap <localleader>r <CMD>lua require('util').run_command()<CR>
nnoremap <localleader>R <CMD>lua require('util').run_command_reset()<CR>

" nnoremap <C-d> <C-d>zz
" nnoremap <C-u> <C-u>zz

nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

nnoremap yc yygccp

nnoremap <leader>p <CMD>Lazy<CR>

xnoremap <C-,> gc

inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-_> <C-o>u
inoremap <M-h> <C-[><C-w>h
inoremap <M-j> <C-[><C-w>j
inoremap <M-k> <C-[><C-w>k
inoremap <M-l> <C-[><C-w>l
inoremap <C-Left> <C-[><C-w>h
inoremap <C-Down> <C-[><C-w>j
inoremap <C-Up> <C-[><C-w>k
inoremap <C-Right> <C-[><C-w>l

tnoremap <C-o> <C-\><C-n>
tnoremap <C-,> <C-\><C-n>
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
tnoremap <C-Left> <C-\><C-n><C-w>h
tnoremap <C-Down> <C-\><C-n><C-w>j
tnoremap <C-Up> <C-\><C-n><C-w>k
tnoremap <C-Right> <C-\><C-n><C-w>l
