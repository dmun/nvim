local extra = require("mini.extra")
local gen_ai_spec = extra.gen_ai_spec

require("mini.ai").setup({
  custom_textobjects = {
    A = gen_ai_spec.buffer(),
    D = gen_ai_spec.diagnostic(),
    i = gen_ai_spec.indent(),
    L = gen_ai_spec.line(),
    N = gen_ai_spec.number(),
  },
})

local misc = require("mini.misc")
misc.setup()
misc.setup_auto_root()
misc.setup_restore_cursor()

require("mini.visits").setup()
require("mini.extra").setup()
require("mini.icons").setup()
