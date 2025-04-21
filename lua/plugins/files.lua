return {
  {
    "echasnovski/mini.nvim",
    enabled = true,
    keys = { { "-", [[<cmd>lua require("mini.files").open()<cr>]] } },
    config = function()
      require("mini.files").setup({
        mappings = {
          go_in = "L",
          go_in_plus = "l",
          -- go_out = "H",
          -- go_out_plus = "h",
        },
      })
    end,
  },
  {
    "airblade/vim-rooter",
    enabled = true,
    init = function()
      vim.g.rooter_silent_chdir = 1
    end,
  },
  {
    "stevearc/oil.nvim",
    enabled = false,
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
        signcolumn = "yes",
        cursorcolumn = false,
        -- foldcolumn = "0",
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
    "cbochs/grapple.nvim",
    config = function()
      local grapple = require("grapple")
      local map = vim.keymap.set

      grapple.setup({
        win_opts = {
          width = 999,
          height = 12,
          row = 0,
          col = 0,

          relative = "editor",
          border = "single",
          focusable = false,
          style = "minimal",

          title = "",
          title_pos = "left",
          title_padding = " ",

          footer = "",
        },
      })

      map("n", "<leader>g", grapple.toggle_tags)
      map("n", "<leader>a", grapple.toggle)
      for i = 1, 5 do
        map("n", "<leader>" .. i, function()
          grapple.select({ index = i })
        end)
      end
    end,
  },
}
