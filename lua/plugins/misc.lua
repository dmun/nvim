return {
  { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    dev = true,
    lazy = false,
    config = function()
      require("snacks").setup({
        bigfile = {},
        quickfile = {},
        statuscolumn = {
          enabled = false,
          left = { "sign", "fold", "git" },
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
    enabled = true,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        fold = { width = 0 },
        segments = {
          { text = { builtin.lnumfunc, " " } },
          { text = { "%s" } },
        },
      })
    end,
  },
}
