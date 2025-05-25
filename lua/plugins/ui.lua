local add = MiniDeps.add

add("jake-stewart/auto-cmdheight.nvim")
require("auto-cmdheight").setup()

require("mini.icons").setup()
require("mini.notify").setup()

local status = require("mini.statusline")
status.setup({
  content = {
    active = function()
      local mode, mode_hl = status.section_mode({ trunc_width = 120 })
      local diff          = status.section_diff({ trunc_width = 75 })
      local filename      = status.section_filename({ trunc_width = 40 })
      local fileinfo      = status.section_fileinfo({ trunc_width = 40 })
      local location      = status.section_location({ trunc_width = 40 })
      local search        = status.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl,      strings = { mode } },
        { hl = "StatusLine", strings = { filename, diff } },
        "%<",
        { hl = "Normal",     strings = {} },
        "%=",
        { hl = "StatusLine", strings = { fileinfo, search } },
        { hl = mode_hl,      strings = { location } },
      })
    end,
  },
})

local starter = require("mini.starter")
starter.setup({
  header = function()
    return vim.fn.expand("%:p")
  end,
  evaluate_single = true,
  items = {
    starter.sections.recent_files(4, false, false),
    starter.sections.recent_files(4, true, false),
    -- starter.sections.sessions(4),
    {
      { action = MiniDeps.update,    name = "u. update",    section = "Deps" },
      { action = MiniDeps.snap_save, name = "n. snap save", section = "Deps" },
      { action = MiniDeps.clean,     name = "c. clean",     section = "Deps" },
    },
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning("center", "center"),
    starter.gen_hook.indexing("all", { "Deps" }),
  },
  footer = "",
  query_updaters = "123456789unc",
  silent = true,
})
