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
  vim.ui.select(files, { prompt = "oldfiles>" }, function(choice)
    if choice then
      vim.cmd("edit " .. choice)
    end
  end)
end)

-- nmap("<Leader>f", function()
--   local files = vim.fn.systemlist("fd -H --color=never --exclude=.git .")
--   local prompt = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
--   vim.ui.select(files, { prompt = prompt }, function(choice)
--     if choice then
--       vim.cmd("find " .. choice)
--     end
--   end)
-- end)

local picker = require("plugins.picker")

nmap("<Leader>f", function()
  local prompt = vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. ">"
  picker.pick(function(callback)
    vim.system({ "fd", "-H", "--color=never", "--exclude=.git", "--type=file", "." }, { text = true }, function(result)
      callback(vim.split(result.stdout, "\n", { trimempty = true }))
    end)
  end, { prompt = prompt }, function(choice)
    if choice then
      vim.cmd("find " .. choice)
    end
  end)
end)

nmap("<Leader>/", function()
  picker.live_grep(vim.fn.getcwd())
end)

local grapple = require("grapple")
grapple.setup({
  icons = false,
  prune = "2d",
  win_opts = {
    width = 56,
    height = 8,
    border = vim.o.winborder,
    title_pos = "left",
    footer = "",
  },
})
nmap("<Leader>a", grapple.tag)
nmap("<Leader>q", grapple.toggle_tags)
nmap("<Leader>Q", grapple.toggle_scopes)
for i = 1, 5 do
  nmap("<Leader>" .. i, function()
    grapple.select({ index = i })
  end)
end
