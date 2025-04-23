return {
  "tpope/vim-rsi",
  { "echasnovski/mini.ai", opts = {} },
  { "nacro90/numb.nvim", event = "CmdLineEnter", opts = {} },
  {
    "Wansmer/treesj",
    keys = { "<space>tj", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local map = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      map({ "n", "x" }, "ga", mc.addCursorOperator)
      map({ "n", "x" }, "<C-k>", function() mc.lineAddCursor(-1) end)
      map({ "n", "x" }, "<C-j>", function() mc.lineAddCursor(1) end)
      map({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
      map({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      map({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end)
      map({ "n", "x" }, "<C-s>", function() mc.matchSkipCursor(1) end)
      map({ "n", "x" }, "<C-p>", function() mc.matchAddCursor(-1) end)
      map({ "n", "x" }, "<C-S-s>", function() mc.matchSkipCursor(-1) end)

      -- Add and remove cursors with control + left click.
      map("n", "<c-leftmouse>", mc.handleMouse)
      map("n", "<c-leftdrag>", mc.handleMouseDrag)
      map("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      map({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<C-o>", mc.prevCursor)
        layerSet({ "n", "x" }, "<C-i>", mc.nextCursor)
        layerSet("n", "<C-;>", mc.alignCursors)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<C-h>", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      map({ "n", "x" }, "<c-q>", mc.toggleCursor)

      map("n", "gm", mc.restoreCursors)
      map("v", "m", mc.matchCursors)
      map("v", "S", mc.splitCursors)
    end,
  },
}
