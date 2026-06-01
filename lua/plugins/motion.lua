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

nmap("<C-a>", function() dial("increment", "normal") end)
nmap("<C-x>", function() dial("decrement", "normal") end)
nmap("g<C-a>", function() dial("increment", "gnormal") end)
nmap("g<C-x>", function() dial("decrement", "gnormal") end)
xmap("<C-a>", function() dial("increment", "visual") end)
xmap("<C-x>", function() dial("decrement", "visual") end)
xmap("g<C-a>", function() dial("increment", "gvisual") end)
xmap("g<C-x>", function() dial("decrement", "gvisual") end)

local jump = require("jump")
jump.setup({
  label = "Visual",
  labels = 'hjklgfdsarewqtyuiopvcxzbnm',
})
map({"n", "x", "o"}, "s", jump.start)
