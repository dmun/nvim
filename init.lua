map = vim.api.nvim_set_keymap

-- Plugins
require('plugins')

-- Vim settings
vim.cmd('source $HOME/.config/nvim/.vimrc')

-- Plugin settings
require('config.barbar')
require('config.colorizer')
require('config.galaxyline')
require('config.gitgutter')
require('config.gitsigns')
require('config.lazygit')
require('config.startify')
require('config.telescope')
require('config.treesitter')
require('config.tree')
require('config.packer')
require('config.whichkey')
require('config.zen')
vim.cmd('source $HOME/.config/nvim/lua/config/coc.vim')
