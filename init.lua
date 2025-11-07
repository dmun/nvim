local plugins = {
  -- ui
  "jake-stewart/auto-cmdheight.nvim",
  "rkjtmp/lush.nvim",
  "dmun/boomer.nvim",

  -- editor
  { "saghen/blink.cmp", version = "v1.7.0" },
  "rafamadriz/friendly-snippets",
  "folke/lazydev.nvim",
  "windwp/nvim-autopairs",
  { "saghen/blink.pairs", version = "v0.3.0" },
  "saghen/blink.download",

  -- files
  "cbochs/grapple.nvim",
  "tpope/vim-sleuth",
  "stevearc/conform.nvim",
  "stevearc/quicker.nvim",
  "stevearc/oil.nvim",
  "ibhagwan/fzf-lua",

  -- lsp
  "mason-org/mason-lspconfig.nvim",
  "mason-org/mason.nvim",
  "neovim/nvim-lspconfig",
  "folke/lazydev.nvim",

  -- llm
  "zbirenbaum/copilot.lua",

  -- motion
  "tpope/vim-rsi",
  "jake-stewart/multicursor.nvim",
  "monaqa/dial.nvim",

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
}

vim.pack.add(
  vim.tbl_map(function(spec)
    local git = "https://github.com/"
    if type(spec) == "table" then
      spec.src = git .. (spec[1] or spec.src)
      return spec
    end
    return { src = git .. spec }
  end, plugins),
  { confirm = true }
)

require("globals")
require("init")
