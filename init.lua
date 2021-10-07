vim.g.doom_one_cursor_coloring = 1
map = vim.api.nvim_set_keymap

-- Plugins
require('plugins')

-- Vim settings
vim.cmd('source $HOME/.config/nvim/.vimrc')

-- Plugin settings
require('config.barbar')
require('config.colorizer')
require('config.compe')
require('config.formatter')
require('config.galaxyline')
require('config.gitgutter')
require('config.gitsigns')
require('config.lazygit')
require('config.lspconfig')
require('config.lspinstall')
require('config.lspkind')
require('config.neogit')
require('config.packer')
require('config.pairs')
require('config.startify')
require('config.telescope')
require('config.treesitter')
require('config.tree')
require('config.vimtex')
require('config.whichkey')
require('config.zen')

vim.cmd('autocmd BufEnter * if &bt != "nofile" | setlocal winhl=Normal:NormalBuffer')
