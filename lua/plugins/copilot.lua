local constants = {
  LLM_ROLE = "llm",
  USER_ROLE = "user",
  SYSTEM_ROLE = "system",
}

local prompts = {
  tutor = [[You are a tutor which has the primary goal of making the user
  intuitively understand concepts. Do not answer the question, but lead the
  user towards the answer. Be concise.]],
  assistant = [[You are an assistent that provides the user with dense and
  concise information.]],
}

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
      "MeanderingProgrammer/render-markdown.nvim",
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      window = {
        layout = "float",
        border = "single",
        width = 1.0,
        height = 0.6,
        row = 0.99,
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
  {
    "echasnovski/mini.diff",
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
    "dmun/codecompanion.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        inline = { adapter = "anthropic" },
        chat = {
          adapter = "anthropic",
          roles = {
            llm = "CodeCompanion",
            user = "Me",
          },
          slash_commands = {
            ["buffer"] = { opts = { provider = "fzf_lua" } },
            ["file"] = { opts = { provider = "fzf_lua" } },
            ["help"] = { opts = { provider = "fzf_lua" } },
            ["symbols"] = { opts = { provider = "fzf_lua" } },
          },
          keymaps = {
            stop = { modes = { n = "gx" } },
            clear = { modes = { n = "<C-l>", i = "<C-l>" } },
          },
        },
      },
      display = {
        diff = {
          enabled = true,
          opts = {
            "internal",
            "filler",
            "closeoff",
            "algorithm:minimal",
            "followwrap",
            "linematch:120",
          },
          provider = "mini_diff",
        },
        chat = {
          intro_message = "Welcome to CodeCompanion! Press ? for options",
          show_header_separator = false,
          start_in_insert_mode = false,
          separator = "─",
          window = {
            layout = "float",
            position = "bottom",
            border = "single",
            row = 0.99,
            col = 0.0,
            height = 0.5,
            width = 1.0,
            relative = "win",
            title_pos = "left",
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "1",
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
      prompt_library = {
        ["Tutor"] = {
          strategy = "chat",
          description = "General guidance",
          opts = {
            index = 0,
            short_name = "tutor",
            is_slash_cmd = true,
            stop_context_insertion = true,
            ignore_system_prompt = true,
          },
          prompts = {
            {
              role = constants.SYSTEM_ROLE,
              content = prompts.tutor,
              opts = {
                visible = false,
              },
            },
            {
              role = constants.USER_ROLE,
              content = " ",
            },
          },
        },
        ["Assistant"] = {
          strategy = "chat",
          description = "Assistant",
          opts = {
            index = 0,
            short_name = "assistant",
            is_slash_cmd = true,
            stop_context_insertion = true,
            ignore_system_prompt = false,
          },
          prompts = {
            {
              role = constants.SYSTEM_ROLE,
              content = prompts.assistant,
              opts = {
                visible = false,
              },
            },
            {
              role = constants.USER_ROLE,
              content = " ",
            },
          },
        },
      },
      opts = {
        ---@param adapter CodeCompanion.Adapter
        ---@return string
        system_prompt = function(adapter)
          return prompts.assistant
        end,
      },
    },
    init = function()
      vim.cmd("au! FileType codecompanion nnoremap <buffer> q <C-w>q")
      vim.keymap.set("n", "<leader>c", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>e", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("v", "<leader>e", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },
}
