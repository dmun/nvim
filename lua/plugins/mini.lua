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

require("mini.diff").setup({
  mappings = {
    apply = "gh",
    reset = "gH",
    textobject = "gh",
    goto_first = "[H",
    goto_prev = "[h",
    goto_next = "]h",
    goto_last = "]H",
  },
  view = { style = "sign" },
})
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
require("mini.visits").setup()
require("mini.extra").setup()
require("mini.icons").setup()

MiniMisc.setup_auto_root()
MiniMisc.setup_restore_cursor()

require("mini.pick").setup({
  options = { use_cache = true },
  window = {
    config = function()
      return {
        -- width = vim.o.co,
      }
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
    window = { config = winopts },
  })
end

nmap("<Leader>td", deps_action)
nmap("<Leader>to", MiniDiff.toggle_overlay)
nmap("g/",         MiniPick.builtin.grep_live)
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
            if (not hash[v]) then
              res[#res + 1] = v
              hash[v] = true
            end
          end

          local fn = function(item)
            local file = vim.fs.basename(item)
            local path = vim.fs.dirname(item)
            path = path == "." and "" or "  " .. path .. "/"
            return {
              text = file .. path,
              path = item,
            }
          end

          return vim.tbl_map(fn, res)
        end

        MiniPick.set_picker_items_from_cli(
          { "rg", "--files", "--no-follow", "--color=never" },
          { postprocess = postprocess }
        )
      end,
      show = function(buf_id, items, query, opts)
        MiniPick.default_show(buf_id, items, query, { show_icons = true })
        local ns_id = vim.api.nvim_get_namespaces()["MiniPickRanges"]
        for row, item in ipairs(items) do
          if not item.path then return end
          local offset_start = string.find(item.text, "  .*$")
          if offset_start then
            local p = #MiniIcons.get("file", item.path)
            pcall(vim.api.nvim_buf_set_extmark, buf_id, ns_id, row - 1, offset_start + p, {
              end_col = item.text:len() + p + 1,
              hl_group = "Comment",
              hl_mode = "combine",
              priority = 200,
            })
          end
        end
      end,
    },
    -- window = { config = winopts },
  })
end)

nmap("<Leader>e", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
  MiniFiles.reveal_cwd()
end)
