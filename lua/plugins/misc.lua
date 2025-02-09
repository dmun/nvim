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
          left = { "sign", "fold", "git" },
        },
        words = {
          debounce = 50,
          modes = { "n", "o" },
        },
      })
    end,
  },
}
