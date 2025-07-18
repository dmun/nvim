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

local format_path = function(item)
  local file = vim.fs.basename(item)
  local path = vim.fs.dirname(item)
  path = path == "." and "" or "  " .. path .. "/"
  return {
    text = file .. path,
    path = item,
  }
end

local path_show = function(buf_id, items, query, opts)
  MiniPick.default_show(buf_id, items, query, { show_icons = false })
  local ns_id = vim.api.nvim_get_namespaces()["MiniPickRanges"]
  for row, item in ipairs(items) do
    if not item.path then
      return
    end
    local offset_start = string.find(item.text, "  .*$")
    if offset_start then
      -- local p = #MiniIcons.get("file", item.path)
      local p = -1
      pcall(vim.api.nvim_buf_set_extmark, buf_id, ns_id, row - 1, offset_start + p, {
        end_col = vim.fn.strdisplaywidth(item.text) + p + 1,
        hl_group = "NonText",
        hl_mode = "combine",
        priority = 200,
      })
    end
  end
end
require("mini.diff").setup({
  mappings = {
    apply = "mg",
    reset = "mG",
    textobject = "mg",
    goto_first = "[c",
    goto_prev = "[c",
    goto_next = "]c",
    goto_last = "]c",
  },
  view = { style = "sign" },
})
require("mini.files").setup({
  mappings = {
    go_in_plus = "l",
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
require("mini.misc").setup()
require("mini.visits").setup()
require("mini.extra").setup()
require("mini.icons").setup()

MiniMisc.setup_auto_root()
MiniMisc.setup_restore_cursor()

require("mini.pick").setup({
  options = { use_cache = true },
  mappings = {
    move_down = "<C-j>",
    move_up = "<C-k>",
  },
  window = {
    config = function()
      return {
        border = { "", " ", "", "", "", "", "", "" },
        col = 0,
        row = vim.o.lines - 1 - vim.o.ch,
        height = math.floor(vim.o.lines - vim.o.lines / 1.615),
        width = vim.o.columns,
        relative = "editor",
      }
    end,
    prompt_caret = "█",
    prompt_prefix = "> ",
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
  return MiniPick.ui_select(items, opts, on_choice)
end

local winopts = function()
  local w, h = 48, 12
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
    -- window = { config = winopts },
  })
end

nmap("<Leader>td", deps_action)
nmap("md", MiniDiff.toggle_overlay)
nmap("g/", MiniPick.builtin.grep_live)
nmap("g?", MiniPick.builtin.help)
nmap("gs", function()
  MiniExtra.pickers.lsp({ scope = "document_symbol" }, {
    window = {
      -- config = winopts,
    },
  })
end)

nmap("<Leader><Leader>", MiniPick.builtin.resume)
nmap("<Leader>g", MiniExtra.pickers.git_files)
nmap("<Leader>o", function()
  MiniPick.start({
    source = {
      name = "Oldfiles",
      items = function()
        local items = {}
        for _, item in ipairs(vim.v.oldfiles) do
          if vim.fn.filereadable(item) == 1 then
            table.insert(items, item)
          end
        end
        local fn = function(item)
          return format_path(item)
        end
        return vim.tbl_map(fn, items)
      end,
      show = path_show,
    },
  })
end)
nmap("<Leader>h", MiniExtra.pickers.hl_groups)
nmap("<M-e>", MiniFiles.open)
nmap("<M-x>", MiniExtra.pickers.keymaps)

nmap("<Leader>f", function()
  MiniPick.start({
    source = {
      name = "Files (frecency)",
      items = function()
        local postprocess = function(items)
          local sort_frecency = MiniVisits.gen_sort.default({ recency_weight = 0.8 })
          local filter_cwd = function(path_data)
            local path = path_data.path
            return vim.startswith(path, vim.fn.getcwd()) and vim.fn.isdirectory(path) == 0
          end

          local visits = MiniVisits.list_paths(vim.fn.getcwd(), {
            sort = sort_frecency,
            filter = filter_cwd,
          })
          vim.list_extend(visits, items)

          local hash = {}
          local res = {}

          for _, v in ipairs(visits) do
            v = vim.fn.fnamemodify(v, ":~:.")
            if not hash[v] then
              res[#res + 1] = v
              hash[v] = true
            end
          end

          return vim.tbl_map(format_path, res)
        end

        MiniPick.set_picker_items_from_cli(
          { "rg", "--files", "--no-follow", "--color=never" },
          { postprocess = postprocess }
        )
      end,
      show = path_show,
    },
    -- window = { config = winopts },
  })
end)
