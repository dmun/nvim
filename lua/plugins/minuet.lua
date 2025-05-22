return require "lazier" {
  "milanglacier/minuet-ai.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  lazy = false,
  config = function()
    require("minuet").setup({
      provider = "codestral",
      n_completions = 1,
      provider_options = {
        codestral = {
          optional = {
            max_tokens = 256,
            stop = { "\n\n" },
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        keymap = {
          accept = "<M-i>",
          accept_line = "<M-l>",
          prev = "<M-[>",
          next = "<M-]>",
          dismiss = "<M-e>",
        },
      },
    })
  end,
}
