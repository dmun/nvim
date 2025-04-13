return {
  { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },
  {
    "folke/snacks.nvim",
    enabled = false,
    priority = 1000,
    lazy = false,
    config = function()
      require("snacks").setup({
        bigfile = {},
        quickfile = {},
        statuscolumn = {
          enabled = true,
          left = {},
          right = {  },
        },
        words = {
          enabled = false,
          debounce = 50,
          modes = { "n", "o" },
        },
      })
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    enabled = false,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { "%s" } },
          { text = { builtin.lnumfunc, " " } },
        },
      })
    end,
  },
}
