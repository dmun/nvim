setl tabstop=2
"setl nornu nonu
"setl signcolumn=no
"setl foldcolumn=1
"nnoremap <buffer> <leader>h <cmd>g/# %% \[markdown\]/norm zc<CR>
"nnoremap <buffer> <CR> <cmd>JupyniumExecuteSelectedCells<CR>
"hi! JupyniumCodeCellContent guibg=#010D18
"hi! JupyniumCodeCellLineNr guibg=#010D18 guifg=#465D70
"nnoremap <buffer> <M-j> <cmd>MoltenNext<cr>zz
"nnoremap <buffer> <M-k> <cmd>MoltenPrev<cr>zz
"nnoremap <buffer> <CR> <cmd>MoltenReevaluateCell<cr>
"vnoremap <buffer> <CR> <cmd>MoltenEvaluateOperator<cr>
"nnoremap <buffer> go <cmd>noautocmd MoltenEnterOutput<cr>
"nnoremap <buffer> <localleader>ra <cmd>MoltenReevaluateAll<cr>
"nnoremap <buffer> <localleader>ev <cmd>MoltenEvaluateVisual<cr> 
"vnoremap <buffer> <CR> <cmd>MoltenEvaluateOperator<cr>
