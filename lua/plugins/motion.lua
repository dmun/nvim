add("cbochs/grapple.nvim")
local grapple = require("grapple")

---@diagnostic disable-next-line: missing-fields
grapple.setup({
  icons = false,
  prune = "2d",
  win_opts = {
    width = 56,
    height = 8,
    border = vim.o.winborder,
    title_pos = "left",
    footer = "",
  },
})

nmap("<Leader>a", grapple.tag)
nmap("<Leader>q", grapple.toggle_tags)
nmap("<Leader>Q", grapple.toggle_scopes)
nmap("<Leader>1", bind(grapple.select, { index = 1 }))
nmap("<Leader>2", bind(grapple.select, { index = 2 }))
nmap("<Leader>3", bind(grapple.select, { index = 3 }))
nmap("<Leader>4", bind(grapple.select, { index = 4 }))
nmap("<Leader>5", bind(grapple.select, { index = 5 }))

add("tpope/vim-rsi")

add("jake-stewart/multicursor.nvim")
local mc = require("multicursor-nvim")
mc.setup()

xmap("q", mc.visualToCursors)
map("ga", mc.matchAllAddCursors)
map({ "n", "x" }, "<C-q>", mc.toggleCursor)
nmap("gm", mc.restoreCursors)
xmap("m", mc.matchCursors)
xmap("S", mc.splitCursors)

map({ "n", "x" }, "<C-n>", bind(mc.matchAddCursor, 1))
map({ "n", "x" }, "<C-p>", bind(mc.matchAddCursor, -1))
map({ "n", "x" }, "gL", bind(mc.matchSkipCursor, 1))
map({ "n", "x" }, "gH", bind(mc.matchSkipCursor, -1))

mc.addKeymapLayer(function(lmap)
  lmap({ "n", "x" }, "<C-o>", mc.prevCursor)
  lmap({ "n", "x" }, "<C-i>", mc.nextCursor)
  lmap({ "n", "x" }, "<C-h>", mc.deleteCursor)
  lmap({ "n", "x" }, "=", mc.alignCursors)
  lmap({ "n", "x" }, "u", "u")
  lmap({ "n", "x" }, "<C-r>", "<C-r>")
  lmap("x", "q", function()
    mc.clearCursors()
    mc.feedkeys("<Esc>", { keycodes = true })
  end)
  lmap("n", "q", mc.clearCursors)
  lmap("n", "<Esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)

add("monaqa/dial.nvim")
local augend = require("dial.augend")
local dial = require("dial.map").manipulate

require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.date.alias["%Y/%m/%d"],
  },
})

nmap("<C-a>", bind(dial, "increment", "normal"))
nmap("<C-x>", bind(dial, "decrement", "normal"))
nmap("g<C-a>", bind(dial, "increment", "gnormal"))
nmap("g<C-x>", bind(dial, "decrement", "gnormal"))
xmap("<C-a>", bind(dial, "increment", "visual"))
xmap("<C-x>", bind(dial, "decrement", "visual"))
xmap("g<C-a>", bind(dial, "increment", "gvisual"))
xmap("g<C-x>", bind(dial, "decrement", "gvisual"))
