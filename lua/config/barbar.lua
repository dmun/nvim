vim.cmd [[
" Barbar settings
nnoremap <silent><M-n> :BufferNext<CR>
nnoremap <silent><M-p> :BufferPrevious<CR>
nnoremap <silent><M-w> :BufferClose<CR>
nnoremap <silent><M-N> :BufferMoveNext<CR>
nnoremap <silent><M-P> :BufferMovePrevious<CR>

" Navigate tabs with meta + number
nnoremap <silent><M-1> :BufferGoto 1<CR>
nnoremap <silent><M-2> :BufferGoto 2<CR>
nnoremap <silent><M-3> :BufferGoto 3<CR>
nnoremap <silent><M-4> :BufferGoto 4<CR>
nnoremap <silent><M-5> :BufferGoto 5<CR>
nnoremap <silent><M-6> :BufferGoto 6<CR>
nnoremap <silent><M-7> :BufferGoto 7<CR>
nnoremap <silent><M-8> :BufferGoto 8<CR>
nnoremap <silent><M-9> :BufferLast<CR>
]]

local tree ={}
tree.toggle_tree = function()
  if view.win_open() then
    require("nvim-tree").close()
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    if package.loaded["bufferline.state"] then
      -- require'bufferline.state'.set_offset(31, 'File Explorer')
      require("bufferline.state").set_offset(31, "")
    end
    require("nvim-tree").find_file(true)
  end
end
return tree 
