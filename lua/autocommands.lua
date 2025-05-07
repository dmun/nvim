local augroup = require("util.augroup")
local group = augroup("CustomAutocommands")

group:au({
  event = { "BufWinEnter", "BufNew" },
  callback = function()
    if vim.bo.buftype == "nofile" then
      vim.wo.winhl = "Normal:NormalFloat"
    end
  end,
})

group:au({
  event = { "FileType" },
  pattern = "qf",
  callback = function()
    vim.wo.rnu = false
    vim.wo.nu = false
  end,
})

group:au({
  event = { "BufRead", "BufEnter" },
  pattern = "config",
  callback = function() vim.bo.ft = "conf" end,
})

group:au({
  event = { "BufRead", "BufEnter" },
  pattern = "hyprland.conf",
  callback = function() vim.bo.ft = "hyprlang" end,
})

group:au({
  event = "TextYankPost",
  callback = function() vim.highlight.on_yank() end,
})

group:au({
  event = "TermOpen",
  callback = function()
    vim.wo.nu = false
    vim.wo.rnu = false
    vim.wo.signcolumn = "no"
  end,
})

group:au({
  event = { "BufEnter", "WinEnter" },
  callback = function()
    if vim.bo.bt == "terminal" then vim.cmd.norm("i") end
  end,
})

group:au({
  event = { "WinEnter", "BufEnter", "BufWinEnter" },
  callback = function()
    vim.wo.statusline = [[%{%v:lua.require'util.statusline'.active()%}]]
  end,
})

group:au({
  event = { "WinLeave" },
  callback = function()
    vim.wo.statusline = [[%{%v:lua.require'util.statusline'.inactive()%}]]
  end,
})
