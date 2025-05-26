local add = MiniDeps.add

add("jake-stewart/auto-cmdheight.nvim")
require("auto-cmdheight").setup()

require("mini.icons").setup()
require("mini.notify").setup({
  content = {
    format = function(notif)
      return notif.msg
    end,
  },
  window = {
    config = {
      title = "",
    },
  },
})
vim.notify = require("mini.notify").make_notify()

-- local starter = require("mini.starter")
-- starter.setup({
--   header = function()
--     return vim.fn.expand("%:p")
--   end,
--   evaluate_single = true,
--   items = {
--     starter.sections.recent_files(4, false, false),
--     starter.sections.recent_files(4, true, false),
--     -- starter.sections.sessions(4),
--     {
--       { action = MiniDeps.update,    name = "u. update",    section = "Deps" },
--       { action = MiniDeps.snap_save, name = "n. snap save", section = "Deps" },
--       { action = MiniDeps.clean,     name = "c. clean",     section = "Deps" },
--     },
--   },
--   content_hooks = {
--     starter.gen_hook.adding_bullet(),
--     starter.gen_hook.aligning("center", "center"),
--     starter.gen_hook.indexing("all", { "Deps" }),
--   },
--   footer = "",
--   query_updaters = "123456789unc",
--   silent = true,
-- })
