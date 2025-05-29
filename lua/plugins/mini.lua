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

require("mini.cursorword").setup()
require("mini.diff").setup({ view = { style = "sign" } })
require("mini.files").setup({
  mappings = {
    go_in_plus  = "l",
    go_out_plus = "h",
  },
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
require("mini.extra").setup()

MiniMisc.setup_auto_root()
MiniMisc.setup_restore_cursor()

require("mini.pick").setup({
  options = { use_cache = true },
  window = {
    config = function()
      return { width = vim.o.co }
    end,
    prompt_caret = "█",
  },
})

---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function(items, opts, on_choice)
  local w, h = 36, #items
  local p = vim.o.winborder == "" and 0 or 2
  local W, H = w + p, h + p
  for _, item in ipairs(items) do
    if #item.action.title > w then
      w = #item.action.title
    end
  end
  return MiniPick.ui_select(items, opts, on_choice, {
    window = {
      config = {
        width = w,
        height = h,
        row = H + 1,
        relative = "cursor",
      },
    },
  })
end

local winopts = function()
  local w, h = 24, 12
  local p = vim.o.winborder == "" and 0 or 2
  local W, H = w + p, h + p

  return {
    width = w,
    height = h,
    col = vim.o.co / 2 - W / 2,
    row = H / 3,
    relative = "editor",
    anchor = "NW",
  }
end

local deps_action = function()
  MiniPick.start({
    source = {
      name = "MiniDeps",
      choose = cmd,
      items = { "DepsUpdate", "DepsClean", "DepsSnapSave" },
    },
    window = { config = winopts },
  })
end

nmap("<Leader>td", deps_action)
nmap("<Leader>to", MiniDiff.toggle_overlay)
nmap("g/",         MiniPick.builtin.grep)
nmap("g?",         MiniPick.builtin.help)
nmap("gs", function()
  MiniExtra.pickers.lsp({ scope = "document_symbol" }, {
    window = {
      config = winopts,
    },
  })
end)

nmap("<Leader><Leader>", MiniPick.builtin.resume)
nmap("<Leader>g",        MiniExtra.pickers.git_files)
nmap("<Leader>o",        MiniExtra.pickers.oldfiles)
nmap("<Leader>h",        MiniExtra.pickers.hl_groups)
nmap("<M-e>",            MiniFiles.open)
nmap("<Leader>f",        bind(MiniExtra.pickers.visit_paths, { preserve_order = true }))
nmap("<Leader>e", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
  MiniFiles.reveal_cwd()
end)
