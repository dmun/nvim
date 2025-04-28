return require "lazier" {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local tj = require("treesj")
    local map = vim.keymap.set

    tj.setup({
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = math.huge,
      cursor_behavior = "start",
      notify = false,
      dot_repeat = true,
    })

    map("n", "gJ", tj.join)
    map("n", "gS", tj.split)
  end,
}
