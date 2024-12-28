return {
  "folke/noice.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  ---@type NoiceConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    notify = { enabled = true },
    messages = { enabled = true },
    popupmenu = { enable = false },
    lsp = {
      signature = { enabled = false },
      documentation = { view = "hover" },
    },
    cmdline = {
      view = "cmdline_popup",
      format = {
        cmdline = { icon = ">", title = "Cmdline" },
        search_down = { icon = ">", title = "Search" },
        search_up = { icon = ">", title = "Search" },
        filter = { icon = ">", title = "Filter" },
        lua = { icon = ">", title = "Lua" },
        help = { icon = ">", title = "Help" },
        input = { view = "cmdline_input", icon = ">" },
      },
    },
    ---@type NoiceConfigViews
    ---@diagnostic disable-next-line: missing-fields
    views = {
      split = {
        relative = "win",
        win_options = {
          number = false,
          relativenumber = false,
        },
      },
      hover = {
        view = "popup",
        relative = "cursor",
        zindex = 45,
        enter = false,
        anchor = "auto",
        size = {
          width = "auto",
          height = "auto",
          max_height = 20,
          max_width = 80,
        },
        border = {
          style = "none",
          padding = { 0, 1 },
        },
        position = { row = 1, col = 0 },
        win_options = {
          wrap = true,
          linebreak = true,
        },
      },
      popup = {
        backend = "popup",
        relative = "editor",
        close = {
          events = { "BufLeave" },
          keys = { "q" },
        },
        enter = true,
        border = {
          style = "rounded",
        },
        position = "50%",
        size = {
          width = "80",
          height = "20",
        },
        win_options = {
          winhighlight = { Normal = "NoicePopupmenu", FloatBorder = "NoicePopupmenu" },
          winbar = "",
          foldenable = false,
        },
      },
      cmdline_input = {
        size = {
          width = "70%",
        },
        position = {
          row = "33%",
          col = "50%",
        },
        border = {
          style = "single",
          text = {
            top_align = "left",
          },
        },
      },
      cmdline_popup = {
        size = {
          width = "80%",
        },
        position = {
          row = "85%",
          col = "50%",
        },
        border = {
          style = "single",
          text = {
            top_align = "left",
          },
        },
      },
      mini = {
        timeout = 1500,
        position = {
          row = -1,
          col = -1,
        },
        size = {
          -- max_height = 1,
        },
        win_options = {
          winblend = 30,
        },
      },
    },
    ---@type NoiceRouteConfig
    ---@diagnostic disable-next-line: missing-fields
    routes = {
      {
        filter = { event = "msg_show", kind = "search_count" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "before" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "after" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "written" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "Modified" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "lines" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "]$" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "AutoSave" },
        opts = { skip = true },
      },
      {
        view = "split",
        filter = { event = "msg_show", min_height = 2 },
      },
    },
  },
}
