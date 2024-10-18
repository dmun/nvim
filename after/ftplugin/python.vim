nnoremap <buffer> <M-j> <cmd>MoltenNext<cr>
nnoremap <buffer> <M-k> <cmd>MoltenPrev<cr>
nnoremap <buffer> <CR> <cmd>MoltenReevaluateCell<cr>
vnoremap <buffer> <CR> <cmd>MoltenEvaluateOperator<cr>
nnoremap <buffer> go <cmd>noautocmd MoltenEnterOutput<cr>
nnoremap <buffer> <localleader>ra <cmd>MoltenReevaluateAll<cr>
nnoremap <buffer> <localleader>ev <cmd>MoltenEvaluateVisual<cr> vnoremap <buffer> <CR> <cmd>MoltenEvaluateOperator<cr>
