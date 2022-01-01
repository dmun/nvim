map('n', '<leader>s', ':Startify<CR>', { silent = true })

vim.g.startify_custom_header = ''

vim.cmd(" let g:startify_lists = [ { 'type': 'files', 'header': ['   Files']}, { 'type': 'sessions',  'header': ['   Sessions']}, { 'type': 'bookmarks', 'header': ['   Bookmarks']}, ] ")
vim.cmd(" let g:startify_bookmarks = [ { 'w': '~/.config/awesome/rc.lua' }, { 'n': '~/.config/nvim/init.lua' }, { 'z': '~/.zshrc' }, ] ")
vim.g.webdevicons_enable_startify = 1
