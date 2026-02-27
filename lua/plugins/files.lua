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

nmap("<Leader>j", function()
  local files = vim
    .iter(vim.v.oldfiles)
    :filter(function(path)
      if path:find("%w://") then
        return false
      end
      if not vim.uv.fs_stat(path) then
        return false
      end
      return true
    end)
    :map(function(path)
      return vim.fn.fnamemodify(path, ":~")
    end)
    :totable()
  vim.ui.select(files, { prompt = "oldfiles" }, function(choice)
    if choice then
      vim.cmd("edit " .. choice)
    end
  end)
end)

nmap("<Leader>f", function()
  local files = vim.fn.systemlist("fd -H --color=never --exclude=.git .")
  vim.ui.select(files, { prompt = "find" }, function(choice)
    if choice then
      vim.cmd("find " .. choice)
    end
  end)
end)
