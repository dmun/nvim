return {
  "eero-lehtinen/oklch-color-picker.nvim",
  config = function()
    require("oklch-color-picker").setup({
      patterns = {
        numbers_in_brackets = false,
      },
    })
  end,
}
