return require "lazier" {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    local map = vim.keymap.set

    mc.setup()

    map({ "n" }, "ga", function()
      mc.matchAllAddCursors()
      mc.feedkeys("ve")
    end)
    map({ "n", "x" }, "<C-q>", mc.toggleCursor)
    map("n", "gm", mc.restoreCursors)
    map("x", "m", mc.matchCursors)
    map("x", "S", mc.splitCursors)

    -- map({ "n", "x" }, "<C-k>", function() mc.lineAddCursor(-1) end)
    -- map({ "n", "x" }, "<C-j>", function() mc.lineAddCursor(1) end)
    map({ "n", "x" }, "gl", function() mc.matchAddCursor(1) end)
    map({ "n", "x" }, "gh", function() mc.matchAddCursor(-1) end)
    map({ "n", "x" }, "gL", function() mc.matchSkipCursor(1) end)
    map({ "n", "x" }, "gH", function() mc.matchSkipCursor(-1) end)

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
}
