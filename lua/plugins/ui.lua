return {
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          normal_hl = "lualine_c_normal", -- Base highlight group in the notification window
          winblend = 0, -- Background color opacity in the notification window
          border = "none", -- Border around the notification window
          zindex = 45, -- Stacking priority of the notification window
          max_width = 0, -- Maximum width of the notification window
          max_height = 1, -- Maximum height of the notification window
          x_padding = 0, -- Padding from right edge of window boundary
          y_padding = -1, -- Padding from bottom edge of window boundary
          align = "bottom", -- How to align the notification window
          relative = "editor", -- What the notification window position is relative to
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = false,
        view = "cmdline",
        format = {
          cmdline = { pattern = "^", icon = false, lang = false, conceal = false },
          search_down = false,
          search_up = false,
          filter = false,
          lua = false,
          help = false,
          input = { view = "cmdline_popup", icon = "󰥻 " }, -- Used by input()
        },
      },
      lsp = {
        progress = { enabled = false },
        signature = { enabled = false },
        hover = { enabled = true },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      messages = { enabled = false },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
