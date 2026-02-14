require("globals")

install({
  -- ui
  "jake-stewart/auto-cmdheight.nvim",
  "rktjmp/lush.nvim",
  "dmun/boomer.nvim",

  -- editor
  { "saghen/blink.cmp", version = "v1.8.0" },
  "rafamadriz/friendly-snippets",
  "folke/lazydev.nvim",
  "windwp/nvim-autopairs",
  { "saghen/blink.pairs", version = "v0.4.1" },
  "saghen/blink.download",

  -- files
  "cbochs/grapple.nvim",
  "tpope/vim-sleuth",
  "stevearc/conform.nvim",
  "stevearc/quicker.nvim",
  "stevearc/oil.nvim",
  "ibhagwan/fzf-lua",
  "A7Lavinraj/fyler.nvim",

  -- lsp
  "mason-org/mason-lspconfig.nvim",
  "mason-org/mason.nvim",
  "neovim/nvim-lspconfig",
  "folke/lazydev.nvim",

  -- llm
  "zbirenbaum/copilot.lua",
  { dev = "dmun/llemper.nvim" },

  -- motion
  -- "justinmk/vim-sneak",
  "tpope/vim-rsi",
  "jake-stewart/multicursor.nvim",
  "monaqa/dial.nvim",
  { src = "https://codeberg.org/andyg/leap.nvim" },

  -- treesitter
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "windwp/nvim-ts-autotag",
  "Wansmer/treesj",

  -- sql
  "tpope/vim-fugitive",
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  "kristijanhusak/vim-dadbod-completion",

  -- misc
  "habamax/vim-godot",
  "nvim-orgmode/orgmode",
  "Thiago4532/mdmath.nvim",
  "nvim-mini/mini.extra",
  "nvim-mini/mini.ai",
  "nvim-mini/mini.misc",
  "nvim-mini/mini.visits",
  "nvim-mini/mini.icons",
  "nvim-mini/mini.hipatterns",
  "nvim-mini/mini.diff",
})

require("options")
require("keymaps")
require("plugins.ui")

vim.schedule(function()
  require("autocommands")
  require("plugins.motion")
  require("plugins.treesitter")
  require("plugins.mini")
  require("plugins.files")
  require("plugins.blink")
  require("plugins.misc")
  require("plugins.lsp")
  require("plugins.llm")
  require("plugins.editor")
end)
