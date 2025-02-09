return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you use the mini.nvim suite
    opts = {
      file_types = {
        "markdown",
        "copilot-chat",
        "codecompanion",
      },
      heading = {
        enabled = true,
        render_modes = { "n", "c", "t", "i" },
        sign = true,
        icons = { "◉ ", "◎ ", "○ ", "✺ ", "▶ ", "⤷ " },
        position = "inline",
        width = "full",
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        backgrounds = {},
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },
      code = {
        enabled = true,
        render_modes = { "n", "c", "t", "i" },
        sign = true,
        style = "normal",
        width = "full",
        left_pad = 1,
        left_margin = 0,
        right_pad = 1,
        min_width = 0,
        above = "▃",
        below = "▀",
      },
      link = { enabled = false },
      bullet = { enabled = false },
      sign = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true,
    keys = {
      { "<leader>e", "<cmd>CopilotChat<cr>" },
    },
    dependencies = {
      "MeanderingProgrammer/render-markdown.nvim",
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      window = {
        layout = "float",
        border = "none",
        width = 1,
        height = 0.95,
        row = 0,
        col = 0,
        relative = "editor",
      },
      show_folds = false,
      highlight_headers = true,
      insert_at_end = true,
      auto_insert_mode = false,
      question_header = "User ",
      answer_header = "Copilot ",
      error_header = "> [!ERROR] Error",
    },
  },
}
