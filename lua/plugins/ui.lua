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
