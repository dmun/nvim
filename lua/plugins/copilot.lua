return {
  {
    "zbirenbaum/copilot.lua",
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
    enabled = false,
    keys = {
      { "<leader>e", "<cmd>CopilotChat<cr>" },
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      window = {
        layout = "float",
        width = 1.0,
        height = 0.99,
        border = "none",
      },
      show_folds = false,
      highlight_headers = true,
      insert_at_end = true,
      auto_insert_mode = false,
      question_header = "User ",
      answer_header = "Copilot ",
      error_header = "Error ",
    },
  },
  {
    "echasnovski/mini.diff",
    version = false,
    config = function()
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "▎", change = "▎", delete = "▎" },
        },
        options = {
          algorithm = "minimal",
        },
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                -- default = "claude-3.5-sonnet",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
          slash_commands = {
            ["buffer"] = { opts = { provider = "fzf_lua" } },
            ["file"] = { opts = { provider = "fzf_lua" } },
            ["help"] = { opts = { provider = "fzf_lua" } },
            ["symbols"] = { opts = { provider = "fzf_lua" } },
          },
        },
        inline = { adapter = "copilot" },
      },
      display = {
        diff = {
          enabled = true,
          provider = "mini_diff",
        },
        chat = {
          window = {
            layout = "buffer", -- float|vertical|horizontal|buffer
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = "no",
              spell = false,
              wrap = true,
              number = false,
              relativenumber = false,
            },
          },
        },
      },
    },
    init = function()
      vim.keymap.set("n", "<leader>e", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("v", "<leader>e", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },
}
