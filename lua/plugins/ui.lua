add("jake-stewart/auto-cmdheight.nvim")
require("auto-cmdheight").setup()

require("mini.icons").setup()
require("util.statusline").setup()

require("mini.notify").setup({
  -- content = {
  --   format = function(notif)
  --     return notif.msg
  --   end,
  -- },
  window = {
    config = {
      title = "",
    },
    winblend = 0,
  },
})
vim.notify = require("mini.notify").make_notify()

-- local autosave_filter = { "sql", "hyprlang"}
-- _G.AUTOSAVE_TIMER = vim.uv.new_timer()
-- au({ "InsertLeave", "TextChanged" }, "*", function()
--   if vim.bo.buftype == "" and not vim.tbl_contains(autosave_filter, vim.bo.filetype) then
--   if _G.AUTOSAVE_TIMER then
--   vim.uv.timer_stop(_G.AUTOSAVE_TIMER)
--     else
--       _G.AUTOSAVE_TIMER = vim.uv.new_timer()
--     end
--     vim.uv.timer_start(_G.AUTOSAVE_TIMER, 200, 0, function()
--       vim.schedule(function()
--         cmd("silent! update")
--       end)
--       vim.uv.timer_stop(_G.AUTOSAVE_TIMER)
--       _G.AUTOSAVE_TIMER = nil
--     end)
--   end
-- end)
