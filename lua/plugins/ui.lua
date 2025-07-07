if TMUX then
  vim.g.tpipeline_split = 1
  vim.g.tpipeline_autoembed = 0
  add("vimpostor/vim-tpipeline")
end

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
-- vim.notify = require("mini.notify").make_notify()
