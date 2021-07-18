map('n', '<M-n>', ':BufferNext<CR>', { silent = true })
map('n', '<M-p>', ':BufferPrevious<CR>', { silent = true })
map('n', '<M-w>', ':BufferClose<CR>', { silent = true })
map('n', '<M-N>', ':BufferMoveNext<CR>', { silent = true })
map('n', '<M-P>', ':BufferMovePrevious<CR>', { silent = true })

for i = 1, 10, 1 do
	map('n', '<M-' .. i .. '>', ':BufferGoto ' .. i .. '<CR>', { silent = true })
end

-- local tree ={}
-- 
-- tree.toggle_tree = function()
--   if view.win_open() then
--     require('nvim-tree').close()
--     if package.loaded['bufferline.state'] then
--       require('bufferline.state').set_offset(0)
--     end
--   else
--     if package.loaded['bufferline.state'] then
--       require('bufferline.state').set_offset(31, '')
--     end
--     require('nvim-tree').find_file(true)
--   end
-- end
-- 
-- return tree
