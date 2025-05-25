local map = vim.keymap.set

local gen_ai_spec = require("mini.extra").gen_ai_spec
require("mini.ai").setup({
  custom_textobjects = {
    A = gen_ai_spec.buffer(),
    D = gen_ai_spec.diagnostic(),
    i = gen_ai_spec.indent(),
    L = gen_ai_spec.line(),
    N = gen_ai_spec.number(),
  },
})

-- require("mini.cursorword").setup()
require("mini.diff").setup({ view = { style = "sign" } })
require("mini.files").setup({
  windows = {
    max_number = 3,
    width_focus = 30,
    width_nofocus = 30,
    width_preview = 30,
    preview = false,
  },
})
require("mini.hipatterns").setup()
require("mini.misc").setup()
require("mini.move").setup()
require("mini.pairs").setup()
-- require("mini.surround").setup()
require("mini.visits").setup()

MiniMisc.setup_auto_root()
MiniMisc.setup_restore_cursor()

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
    prompt_caret = "█",
  },
})

vim.notify = require("mini.notify").make_notify()
vim.ui.select = function(items, opts, on_choice)
  local width, height = 36, #items
  for _, item in ipairs(items) do
    if #item.action.title > width then
      width = #item.action.title
    end
  end
  return MiniPick.ui_select(items, opts, on_choice, {
    window = {
      config = {
        width = width,
        height = height,
        row = height + 3,
        col = -1,
        relative = "cursor",
      },
    },
  })
end

local winopts = function()
  local w, h = 24, 12
  return {
    width = w,
    height = 12,
    col = vim.o.co / 2 - w / 2,
    row = h / 2 + h,
    relative = "editor",
  }
end

map("n", "g/", mp.builtin.grep)
map("n", "g?", mp.builtin.help)
map("n", "gs", function()
  mx.pickers.lsp({ scope = "document_symbol" }, {
    window = {
      config = winopts,
    },
  })
end)
map("n", "<Leader><Leader>", mp.builtin.resume)
map("n", "<Leader>f", mp.builtin.files)
map("n", "<Leader>o", mx.pickers.oldfiles)
map("n", "<Leader>h", mx.pickers.hl_groups)
map("n", "<Leader>q", function() mx.pickers.visit_paths() end)
map("n", "<Leader>l", function() MiniVisits.add_path() end)
map("n", "<M-e>", MiniFiles.open)
map("n", "<Leader>e", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
  MiniFiles.reveal_cwd()
end)
