map('n', '<leader>ff', [[:lua require('telescope.builtin').find_files()<CR>]], { silent = true })
map('n', '<leader>fg', [[:lua require('telescope.builtin').live_grep()<CR>]], { silent = true })
map('n', '<leader>fb', [[:lua require('telescope.builtin').buffers()<CR>]], { silent = true })
map('n', '<leader>fh', [[:lua require('telescope.builtin').help_tags()<CR>]], { silent = true })
