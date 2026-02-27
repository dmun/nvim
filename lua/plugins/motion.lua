local grapple = require("grapple")
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
for i = 1, 5 do
  nmap("<Leader>" .. i, function()
    grapple.select({ index = i })
  end)
end

local mc = require("multicursor-nvim")
mc.setup()
vim.keymap.set({ "n", "x" }, "<C-q>", mc.toggleCursor)
vim.keymap.set("", "ga", mc.matchAllAddCursors)
nmap("gm", mc.restoreCursors)
xmap("q", mc.visualToCursors)
xmap("m", mc.matchCursors)
xmap("S", mc.splitCursors)
vim.keymap.set({ "n", "x" }, "<C-j>", function()
  mc.lineAddCursor(1)
end)
vim.keymap.set({ "n", "x" }, "<C-k>", function()
  mc.lineAddCursor(-1)
end)
vim.keymap.set({ "n", "x" }, "<C-n>", function()
  mc.matchAddCursor(1)
end)
vim.keymap.set({ "n", "x" }, "<C-p>", function()
  mc.matchAddCursor(-1)
end)
vim.keymap.set({ "n", "x" }, "gL", function()
  mc.matchSkipCursor(1)
end)
vim.keymap.set({ "n", "x" }, "gH", function()
  mc.matchSkipCursor(-1)
end)
mc.addKeymapLayer(function(lmap)
  lmap({ "n", "x" }, "<C-o>", mc.prevCursor)
  lmap({ "n", "x" }, "<C-i>", mc.nextCursor)
  lmap({ "n", "x" }, "<C-h>", mc.deleteCursor)
  lmap({ "n", "x" }, "=", mc.alignCursors)
  lmap({ "n", "x" }, "u", "u")
  lmap({ "n", "x" }, "<C-r>", "<C-r>")
  lmap("n", "q", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)

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

-- stylua: ignore start
nmap("<C-a>", function() dial("increment", "normal") end)
nmap("<C-x>", function() dial("decrement", "normal") end)
nmap("g<C-a>", function() dial("increment", "gnormal") end)
nmap("g<C-x>", function() dial("decrement", "gnormal") end)
xmap("<C-a>", function() dial("increment", "visual") end)
xmap("<C-x>", function() dial("decrement", "visual") end)
xmap("g<C-a>", function() dial("increment", "gvisual") end)
xmap("g<C-x>", function() dial("decrement", "gvisual") end)

-- map({'n', 'x', 'o'}, 's', '<Plug>(leap)')
-- nmap('S', '<Plug>(leap-from-window)')

-- map("w", "<cmd>lua require('spider').motion('w')<CR>")
-- map("e", "<cmd>lua require('spider').motion('e')<CR>")
-- map("b", "<cmd>lua require('spider').motion('b')<CR>")
-- map("ge", "<cmd>lua require('spider').motion('ge')<CR>")
