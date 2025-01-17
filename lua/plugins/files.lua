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
    keys = { { "-", "<cmd>Oil --float<cr>" } },
    opts = {
      default_file_explorer = true,
      view_options = {
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".") or vim.endswith(name, ".pdf")
        end,
      },
      float = {
        border = "single",
        max_height = 0.5,
        padding = 0,
        override = function(conf)
          conf.row = math.floor((vim.o.lines - 4) / 2)
          return conf
        end,
      },
      win_options = {
        number = false,
        relativenumber = false,
        wrap = false,
        signcolumn = "yes",
        cursorcolumn = false,
        foldcolumn = "0",
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
        "<M-t>",
        function()
          require("harpoon"):list():select(1)
        end,
      },
      {
        "<M-s>",
        function()
          require("harpoon"):list():select(2)
        end,
      },
      {
        "<M-r>",
        function()
          require("harpoon"):list():select(3)
        end,
      },
      {
        "<M-a>",
        function()
          require("harpoon"):list():select(4)
        end,
      },
    },
  },
}
