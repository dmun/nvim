-- Fyler
local fyler = require("fyler")
fyler.setup({
  views = {
    ---@diagnostic disable: missing-fields
    finder = {
      indentscope = {
        enabled = false,
      },
      win = {
        -- kind = "split_right",
        win_opts = {
          signcolumn = "yes:1",
        },
      },
      mappings = {
        ["<Tab>"] = "Select",
      },
    },
  },
})
nmap("<Leader>e", fyler.open)

-- Oil
local oil = require("oil")
oil.setup({
  -- win_options = {
  --   signcolumn = "yes:1",
  --   number = false,
  --   relativenumber = false,
  preview_win = {},
  keymaps = {
    ["<Tab>"] = "actions.select",
    q = "actions.close",
  },
})
nmap("-", oil.open)

-- Fzf
local fzf = require("fzf-lua")
fzf.setup({
  defaults = { previewer = false, file_icons = false },
  fzf_colors = {
    ["bg+"] = { "bg", "CursorLine" },
    ["fg+"] = { "fg", "Normal" },
  },
  winopts = { split = "belowright new", title = false },
})
nmap("<Leader>f", fzf.files)
nmap("<Leader>j", fzf.oldfiles)
nmap("<Leader>/", fzf.live_grep)
nmap("<Leader>h", fzf.highlights)
nmap("<Leader><Leader>", "<Cmd>FzfLua<CR>")
