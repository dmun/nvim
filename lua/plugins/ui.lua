return {
  {
    "j-hui/fidget.nvim",
    config = true,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true,
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
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      messages = { enabled = true },
    },
  },
}
