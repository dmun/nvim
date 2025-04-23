local map = vim.keymap.set

return {
  "svban/YankAssassin.vim",
  { "tpope/vim-fugitive", dependencies = "tpope/vim-rhubarb" },
  { "numToStr/Comment.nvim", event = "VeryLazy" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
      require("nvim-autopairs").remove_rule("`")
    end,
  },
  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require("dial.augend")
      local dial = require("dial.map")

      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.date.alias["%Y/%m/%d"],
        },
      })

      map("n", "<C-a>", function() dial.manipulate("increment", "normal") end)
      map("n", "<C-x>", function() dial.manipulate("decrement", "normal") end)
      map("n", "g<C-a>", function() dial.manipulate("increment", "gnormal") end)
      map("n", "g<C-x>", function() dial.manipulate("decrement", "gnormal") end)
      map("v", "<C-a>", function() dial.manipulate("increment", "visual") end)
      map("v", "<C-x>", function() dial.manipulate("decrement", "visual") end)
      map("v", "g<C-a>", function() dial.manipulate("increment", "gvisual") end)
      map("v", "g<C-x>", function() dial.manipulate("decrement", "gvisual") end)
    end,
  },
  {
    "NMAC427/guess-indent.nvim",
    event = "VeryLazy",
    config = function()
      require("guess-indent").setup({
        auto_cmd = true,
        override_editorconfig = false,
        filetype_exclude = {
          "netrw",
          "tutor",
        },
        buftype_exclude = {
          "help",
          "nofile",
          "terminal",
          "prompt",
        },
        on_tab_options = {
          expandtab = false,
        },
        on_space_options = {
          expandtab = true,
          tabstop = "detected",
          softtabstop = "detected",
          shiftwidth = "detected",
        },
      })
    end,
  },
  {
    "dmun/autosave.nvim",
    init = function() vim.g.autosave_enabled = true end,
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "s",
          normal_cur = "ss",
          -- normal_line = "S",
          normal_cur_line = "S",
          visual = "s",
          visual_line = "S",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      })
    end,
  },
}
