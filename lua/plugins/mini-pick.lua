return {
  "echasnovski/mini.pick",
  lazy = false,
  dependencies = "echasnovski/mini.extra",
  config = function()
    local map = vim.keymap.set
    local mp = require("mini.pick")
    local mx = require("mini.extra")

    mx.setup()
    mp.setup({
      options = {
        use_cache = true,
      },
      window = {
        config = function()
          return {
            width = vim.o.columns,
          }
        end,
        prompt_caret = "▎",
      },
    })

    vim.ui.select = function(items, opts, on_choice)
      local width, height = 36, #items
      for _, item in ipairs(items) do
        if #item.action.title > width then
          width = #item.action.title
        end
      end

      local start_opts = {
        window = {
          config = {
            width = width,
            height = height,
            row = height + 3,
            col = -1,
            relative = "cursor",
          },
        },
      }

      return MiniPick.ui_select(items, opts, on_choice, start_opts)
    end

    map("n", "<leader>f", function() mp.builtin.files({ tool = "git" }) end)
    map("n", "g/", mp.builtin.grep)
    map("n", "<leader><leader>", mp.builtin.resume)
    map("n", "g?", mp.builtin.help)

    map("n", "<leader>o", mx.pickers.oldfiles)
    map("n", "<leader>h", mx.pickers.hl_groups)
    map("n", "grr", function() mx.pickers.lsp({ scope = "references" }) end)
    map("n", "gs", function() mx.pickers.lsp({ scope = "document_symbol" }) end)
    map("n", "gd", function() mx.pickers.lsp({ scope = "definition" }) end)
    map("n", "gD", function() mx.pickers.lsp({ scope = "declaration" }) end)
    map("n", "<leader>q", function() mx.pickers.list({ scope = "quickfix" }) end)
  end,
}
