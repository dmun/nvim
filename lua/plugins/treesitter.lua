return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      modules = {},
      ignore_install = {},
      sync_install = true,
      auto_install = false,
      indent = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      ensure_installed = {
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "query",
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          include_surrounding_whitespace = false,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["as"] = "@local.scope",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
          },
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
        },
      },
    })
  end,
}
