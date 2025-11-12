require("nvim-ts-autotag").setup()

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "org" },
  indent = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        af = "@function.outer",
        ["if"] = "@function.inner",
        ac = "@class.outer",
        ic = "@class.inner",
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        node_incremental = "v",
        node_decremental = "V",
      },
    },
  },
})

local tj = require("treesj")
tj.setup({ use_default_keymaps = false })
nmap("gJ", tj.toggle)
