-- Optimize startup time.
pcall(require, "impatient")

-- Load Neovim defaults.
require "defaults"

-- Load plugins.
require "plugins"

-- Load configs (temporary).
require "core.cmp"
require "core.colorizer"
require "core.gitsigns"
require "core.lspconfig"
require "core.mason"
require "core.lspkind"
require "core.lualine"
require "core.packer"
require "core.pairs"
require "core.tree"
require "core.treesitter"
require "core.neorg"
require "core.fzf"
require "treesj".setup({
    use_default_keymaps = true,
})

-- Hide the (real) cursor when leaping, and restore it afterwards.
vim.api.nvim_create_autocmd('User', { pattern = 'LeapEnter',
    callback = function()
      vim.cmd.hi('Cursor', 'blend=100')
      vim.opt.guicursor:append { 'a:Cursor/lCursor' }
    end,
  }
)
vim.api.nvim_create_autocmd('User', { pattern = 'LeapLeave',
    callback = function()
      vim.cmd.hi('Cursor', 'blend=0')
      vim.opt.guicursor:remove { 'a:Cursor/lCursor' }
    end,
  }
)

-- Theme
require "core.catppuccin"
