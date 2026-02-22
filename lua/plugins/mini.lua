local extra = require("mini.extra")
local gen_ai_spec = extra.gen_ai_spec

-- require("mini.ai").setup({
--   custom_textobjects = {
--     A = gen_ai_spec.buffer(),
--     D = gen_ai_spec.diagnostic(),
--     i = gen_ai_spec.indent(),
--   },
-- })

local misc = require("mini.misc")
misc.setup()
misc.setup_auto_root()
misc.setup_restore_cursor()

require("mini.visits").setup()
require("mini.extra").setup()
require("mini.icons").setup()
require("mini.diff").setup({
  view = {
    style = "sign",
  },
  mappings = {
    goto_next = "]c",
    goto_prev = "[c",
  },
})
nmap("coh", MiniDiff.toggle_overlay)

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
    hsl_color = {
      pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
      group = function(_, match)
        local util = require("util")
        local h, s, l = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
        h, s, l = tonumber(h), tonumber(s), tonumber(l)
        local hex_color = util.hslToHex(h, s, l)
        return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
      end,
    },
  },
})
