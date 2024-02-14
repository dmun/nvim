autocmd! FileType fzf,NeogitPopup,Trouble
autocmd FileType fzf,NeogitPopup,Trouble set laststatus=0
    \| autocmd BufLeave <buffer> set laststatus=2

nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
nnoremap <expr> 0 &wrap ? 'g0' : '0'
nnoremap <expr> $ &wrap ? 'g$' : '$'

