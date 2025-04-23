local map = vim.keymap.set

return {
  "tpope/vim-rsi",
  { "echasnovski/mini.ai", config = true },
  { "nacro90/numb.nvim", event = "CmdLineEnter", config = true },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local tj = require("treesj")

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
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      map({ "n", "x" }, "ga", mc.addCursorOperator)
      map({ "n", "x" }, "<C-q>", mc.toggleCursor)
      map("n", "gm", mc.restoreCursors)
      map("x", "m", mc.matchCursors)
      map("x", "S", mc.splitCursors)

      map({ "n", "x" }, "<C-k>", function() mc.lineAddCursor(-1) end)
      map({ "n", "x" }, "<C-j>", function() mc.lineAddCursor(1) end)
      map({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end)
      map({ "n", "x" }, "<C-s>", function() mc.matchSkipCursor(1) end)
      map({ "n", "x" }, "<C-p>", function() mc.matchAddCursor(-1) end)
      map({ "n", "x" }, "<C-S-s>", function() mc.matchSkipCursor(-1) end)

      mc.addKeymapLayer(function(layermap)
        layermap({ "n", "x" }, "<C-o>", mc.prevCursor)
        layermap({ "n", "x" }, "<C-i>", mc.nextCursor)
        layermap({ "n", "x" }, "<C-h>", mc.deleteCursor)
        layermap({ "n", "x" }, "<C-;>", mc.alignCursors)

        layermap("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)
    end,
  },
}
