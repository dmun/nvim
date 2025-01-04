return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      { "<leader>e", "<cmd>CopilotChat<cr>" },
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
  },
}
