return {
  {
    "airblade/vim-rooter",
    enabled = true,
    init = function()
      vim.g.rooter_silent_chdir = 1
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    keys = { { "-", "<cmd>Oil<cr>" } },
    opts = {
      default_file_explorer = true,
      view_options = {
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".") or vim.endswith(name, ".pdf")
        end,
      },
      win_options = {
        number = false,
        relativenumber = false,
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "1",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
      },
    },
  },
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    keys = {
      {
        "<leader>m",
        function()
          require("harpoon"):list():add()
        end,
      },
      {
        "<leader>q",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
      },
      {
        "<M-1>",
        function()
          require("harpoon"):list():select(1)
        end,
      },
      {
        "<M-2>",
        function()
          require("harpoon"):list():select(2)
        end,
      },
      {
        "<M-3>",
        function()
          require("harpoon"):list():select(3)
        end,
      },
      {
        "<M-4>",
        function()
          require("harpoon"):list():select(4)
        end,
      },
    },
  },
}
