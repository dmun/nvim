return {
  "rktjmp/lush.nvim",
  {
    "dmun/boomer.nvim",
    dev = true,
    init = function()
      vim.cmd.color("boomer")
    end,
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    enabled = true,
    ---@type oklch.Opts
    opts = {
      highlight = {
        -- style = "virtual_left",
        -- virtual_text = "  ",
        -- emphasis = false,
      },
      patterns = {
        lua_oklch = {
          "oklch%(()[%d.,%s]+()%)",
          format = "raw_oklch",
          priority = -1,
          ft = { "lua" },
        },
        numbers_in_brackets = false,
      },
    },
  },
}
