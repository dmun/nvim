local map = vim.keymap.set
local add = MiniDeps.add

add("tpope/vim-rsi")

add("ggandor/leap.nvim")
require("leap").set_default_mappings()

add("jake-stewart/multicursor.nvim")
local mc = require("multicursor-nvim")
mc.setup()

--- @param ctx mc.CursorContext
--- @param motion? string | fun(cursor: mc.Cursor)
local function addCursor(ctx, motion, opts)
  opts = opts or {}
  if opts.remap == nil then
    opts.remap = true
  end
  if motion then
    local mainCursor = ctx:mainCursor()
    if opts.addCursor then
      mainCursor:clone()
    end
    local vs, ve = mainCursor:getVisual()
    local oldMode = mainCursor:mode()
    local atVisStart = mainCursor:atVisualStart()
    if type(motion) == "string" then
      mainCursor:feedkeys(motion, opts)
    else
      motion(mainCursor)
    end
    local newPos = mainCursor:getPos()
    local rowDiff = newPos[1] - vs[1]
    local colDiff = mainCursor:mode() == "n"
        and newPos[2] - vs[2]
        or atVisStart
        and vs[2] - newPos[2]
        or newPos[2] - ve[2]
    mainCursor:setMode(oldMode)
    local startRow = vs[1] + rowDiff
    local startCol = vs[2] + colDiff
    local endRow = ve[1] + rowDiff
    local endCol = ve[2] + colDiff
    local lastLine = vim.fn.line("$")
    if endRow > lastLine then
      endRow = lastLine
      endCol = vim.fn.col({ lastLine, "$" })
    end
    if oldMode == "V" or oldMode == "S" then
      startCol = vs[2]
      endCol = ve[2]
    end
    if atVisStart then
      mainCursor:setVisual(
        { endRow, endCol },
        { startRow, startCol }
      )
    else
      mainCursor:setVisual(
        { startRow, startCol },
        { endRow, endCol }
      )
    end
  else
    ctx:forEachCursor(function(cursor)
      if cursor:isMainCursor() then
        cursor:clone():disable()
        cursor:setMode("n")
      else
        cursor:disable()
      end
    end)
  end
end

--- Returns whether the string is considered a keyword
--- @param s string
--- @return boolean
local function isKeyword(s)
  return vim.fn.match(s, "\\v^\\k+$") >= 0
end

--- Escape regex for search
--- @param regex string
--- @return string
local function escapeRegex(regex)
  regex = vim.fn.substitute(regex, "\\", "\\\\\\\\", "g")
  regex = vim.fn.substitute(regex, "/", "\\\\/", "g")
  regex = vim.fn.substitute(regex, "\n", "\\\\n", "g")
  return regex
end

_G.SEARCH_WORD = nil
---@param direction? -1 | 1
---@param skip? boolean
local function matchCursorSelect(direction, skip)
  mc.action(function(ctx)
    for _ = 1, vim.v.count1 do
      local mainCursor = ctx:mainCursor()
      local cursorChar
      local cursorWord
      if not mainCursor:hasSelection() then
        local c = mainCursor:col()
        cursorChar = string.sub(mainCursor:getLine(), c, c)
        cursorWord = mainCursor:getCursorWord()
        if cursorChar ~= ""
            and isKeyword(cursorChar)
            and string.find(cursorWord, cursorChar, 1, true)
        then
          _G.SEARCH_WORD = cursorWord
          mainCursor:feedkeys("viw")
        end
      end
      addCursor(ctx, function(cursor)
        local regex
        local hasSelection = cursor:hasSelection()
        if hasSelection then
          regex = escapeRegex(table.concat(cursor:getVisualLines(), "\n"))
          if _G.SEARCH_WORD == regex then
            regex = "\\<" .. regex .. "\\>"
          else
            _G.SEARCH_WORD = nil
          end
          regex = "\\C\\V" .. regex
          if vim.o.selection == "exclusive" then
            regex = regex .. "\\v(.*\\n)@="
          end
          if cursor:mode() == "V" or cursor:mode() == "S" then
            cursor:feedkeys(cursor:atVisualStart() and "0" or "o0")
          elseif not cursor:atVisualStart() then
            cursor:feedkeys("o")
          end
        end
        cursor:perform(function()
          vim.fn.search(regex, (direction == -1 and "b" or ""))
        end)
        if hasSelection then
          cursor:feedkeys("")
        end
      end, { addCursor = not skip })
    end
  end)
end

local function matchAddCursorSelect(direction)
  matchCursorSelect(direction)
end

local function matchSkipCursorSelect(direction)
  matchCursorSelect(direction, true)
end

local function clearCursors()
  mc.clearCursors()
  _G.MC_WORD = false
end

map("x", "q", mc.visualToCursors)
map("x", "ga", function() mc.matchAllAddCursors() end)
map("n", "ga", function()
  mc.matchAllAddCursors()
  mc.feedkeys("viw")
end)
map({ "n", "x" }, "<C-q>", mc.toggleCursor)
map("n", "gm", mc.restoreCursors)
map("x", "m", mc.matchCursors)
map("x", "S", mc.splitCursors)

map({ "n", "x" }, "L", function() matchAddCursorSelect(1) end)
map({ "n", "x" }, "H", function() matchAddCursorSelect(-1) end)
map({ "n", "x" }, "M", function() matchSkipCursorSelect(1) end)

mc.addKeymapLayer(function(layermap)
  layermap({ "n", "x" }, "<C-o>", mc.prevCursor)
  layermap({ "n", "x" }, "<C-i>", mc.nextCursor)
  layermap({ "n", "x" }, "<C-h>", mc.deleteCursor)
  layermap({ "n", "x" }, "=", mc.alignCursors)
  layermap({ "n", "x" }, "u", "u")
  layermap({ "n", "x" }, "<C-r>", "<C-r>")
  layermap("n", "q", clearCursors)
  layermap("x", "q", function()
    clearCursors()
    mc.feedkeys("<Esc>", { keycodes = true })
  end)
  layermap("n", "<Esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      clearCursors()
    end
  end)
end)

add("monaqa/dial.nvim")
local augend = require("dial.augend")
local dial = require("dial.map")

require("dial.config").augends:register_group {
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.date.alias["%Y/%m/%d"],
  },
}

map("n", "<C-a>", function() dial.manipulate("increment", "normal") end)
map("n", "<C-x>", function() dial.manipulate("decrement", "normal") end)
map("n", "g<C-a>", function() dial.manipulate("increment", "gnormal") end)
map("n", "g<C-x>", function() dial.manipulate("decrement", "gnormal") end)
map("v", "<C-a>", function() dial.manipulate("increment", "visual") end)
map("v", "<C-x>", function() dial.manipulate("decrement", "visual") end)
map("v", "g<C-a>", function() dial.manipulate("increment", "gvisual") end)
map("v", "g<C-x>", function() dial.manipulate("decrement", "gvisual") end)
