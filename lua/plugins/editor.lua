return {
  "tpope/vim-fugitive",
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
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.constant.alias.bool, -- boolean value (true <-> false)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        },
      })

      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gnormal")
      end)
      vim.keymap.set("v", "<C-a>", function()
        require("dial.map").manipulate("increment", "visual")
      end)
      vim.keymap.set("v", "<C-x>", function()
        require("dial.map").manipulate("decrement", "visual")
      end)
      vim.keymap.set("v", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gvisual")
      end)
      vim.keymap.set("v", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gvisual")
      end)
    end,
  },
  {
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "dmun/autosave.nvim",
    config = function()
      vim.g.autosave_enabled = true
    end,
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
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufRead", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async", "kiyoon/jupynium.nvim" },
    opts = {
      provider_selector = function(bufnr, ft, bt)
        local ufo = require("ufo")
        local function get_cell_folds(bufnr)
          local function handleFallbackException(err, providerName)
            if type(err) == "string" and err:match("UfoFallbackException") then
              return ufo.getFolds(bufnr, providerName)
            else
              return require("promise").reject(err)
            end
          end
          return ufo
            .getFolds(bufnr, "lsp")
            :catch(function(err)
              return handleFallbackException(err, "treesitter")
            end)
            :catch(function(err)
              return handleFallbackException(err, "indent")
            end)
            :thenCall(function(ufo_folds)
              local ok, jupynium = pcall(require, "jupynium")
              if ok then
                for _, fold in ipairs(jupynium.get_folds()) do
                  table.insert(ufo_folds, fold)
                end
              end
              return ufo_folds
            end)
        end
        if ft == "python" then return get_cell_folds end
        return { "treesitter", "indent" }
      end,
    },
  },
}
