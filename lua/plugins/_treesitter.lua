add("nvim-treesitter/nvim-treesitter")

add({
  source = "nvim-treesitter/nvim-treesitter-textobjects",
  depends = { "nvim-treesitter/nvim-treesitter" },
})

add({
  source = "windwp/nvim-ts-autotag",
  depends = { "nvim-treesitter/nvim-treesitter" },
})
require("nvim-ts-autotag").setup()

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  indent = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  modules = {},
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "v",
      node_decremental = "V",
    },
  },
})

add({
  source = "Wansmer/treesj",
  depends = { "nvim-treesitter/nvim-treesitter" },
})

local tj = require("treesj")
tj.setup({ use_default_keymaps = false })

-- nmap("gS", tj.split)
nmap("gJ", tj.toggle)
