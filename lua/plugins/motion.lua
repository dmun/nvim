return require "lazier" {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    local map = vim.keymap.set

    mc.setup()

    ---@param direction integer 1 for forward, -1 for backward
    local matchAddCursorVisual = function(direction)
      if _G.MC_WORD == true then
        vim.cmd.norm("")
        mc.matchAddCursor(direction)
        mc.feedkeys("viw")
      else
        mc.matchAddCursor(direction)
      end
    end

    map("x", "ga", function() mc.matchAllAddCursors() end)
    map("n", "ga", function()
      mc.matchAllAddCursors()
      mc.feedkeys("viw")
    end)
    map({ "n", "x" }, "<C-q>", mc.toggleCursor)
    map("n", "gm", mc.restoreCursors)
    map("x", "m", mc.matchCursors)
    map("x", "S", mc.splitCursors)

    map({ "n", "x" }, "<C-p>", function() mc.lineAddCursor(-1) end)
    map({ "n", "x" }, "<C-n>", function() mc.lineAddCursor(1) end)
    map({ "x" }, "gl", function() matchAddCursorVisual(1) end)
    map({ "n" }, "gl", function()
      mc.matchAddCursor(1)
      mc.feedkeys("viw")
      _G.MC_WORD = true
    end)

    map({ "x" }, "gH", function() mc.matchSkipCursor(-1) end)
    map({ "n" }, "gh", function()
      mc.matchAddCursor(-1)
      mc.feedkeys("viw")
    end)

    map({ "x" }, "gL", function() mc.matchSkipCursor(1) end)
    map({ "n" }, "gL", function()
      mc.matchSkipCursor(1)
      mc.feedkeys("viw")
    end)

    map({ "x" }, "gh", function() mc.matchAddCursorVisual(-1) end)
    map({ "n" }, "gH", function()
      _G.MC_WORD = true
      mc.matchSkipCursor(-1)
      mc.feedkeys("viw")
    end)

    mc.addKeymapLayer(function(layermap)
      layermap({ "n", "x" }, "<C-o>", mc.prevCursor)
      layermap({ "n", "x" }, "<C-i>", mc.nextCursor)
      layermap({ "n", "x" }, "<C-h>", mc.deleteCursor)
      layermap({ "n", "x" }, "<C-;>", mc.alignCursors)

      layermap("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          _G.MC_WORD = false
          mc.clearCursors()
        end
      end)
    end)
  end,
}
