return {
  {
    "dmun/boomer.nvim",
    dev = true,
    dependencies = "rktjmp/lush.nvim",
    priority = 1000,
    init = function() vim.cmd.color("boomer") end,
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    config = function()
      require("oklch-color-picker").setup({
        patterns = {
          numbers_in_brackets = false,
        },
      })
    end,
  },
}
