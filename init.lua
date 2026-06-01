require("globals")

install({
  -- editor
  { "saghen/blink.cmp", version = "v1.9.1" },
  "rafamadriz/friendly-snippets",
  "folke/lazydev.nvim",
  "windwp/nvim-autopairs",
  "saghen/blink.download",
  "tpope/vim-sleuth",

  -- ui
  "nvim-mini/mini.hipatterns",

  -- files
  "cbochs/grapple.nvim",
  "stevearc/conform.nvim",
  "stevearc/quicker.nvim",
  "stevearc/oil.nvim",

  -- lsp
  "mason-org/mason-lspconfig.nvim",
  "mason-org/mason.nvim",
  "neovim/nvim-lspconfig",

  -- motion
  "tpope/vim-rsi",
  "monaqa/dial.nvim",
  "yorickpeterse/nvim-jump",

  -- git
  "tpope/vim-fugitive",
  "nvim-mini/mini.diff",

  -- misc
  "nvim-mini/mini.misc",
})

require("options")
require("keymaps")

vim.schedule(function()
  require("autocommands")
  require("plugins.motion")
  require("plugins.mini")
  require("plugins.files")
  require("plugins.blink")
  require("plugins.lsp")
  require("plugins.editor")
end)
