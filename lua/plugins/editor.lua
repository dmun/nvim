return {
  "https://github.com/tpope/vim-fugitive",
  { "numToStr/Comment.nvim", event = "VeryLazy" },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "dstein64/nvim-scrollview", enabled = false, config = true },
  { "folke/trouble.nvim", opts = { focus = true } },
  {
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "Pocco81/auto-save.nvim",
    enabled = true,
    config = function()
      require("auto-save").setup({
        condition = function(buf)
          local ft = vim.bo.filetype
          local fts = {
            "oil",
            "harpoon",
            "fzf",
            "codecompanion",
          }

          if vim.tbl_contains(fts, ft) then
            return false
          end

          return true
        end,
      })
    end,
  },
  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
      scope = "cursor",
      padding_right = 2,
      toggle_event = { "InsertEnter", "InsertLeave" },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
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
        if ft == "python" then
          return get_cell_folds
        end
        return { "treesitter", "indent" }
      end,
    },
  },
}
