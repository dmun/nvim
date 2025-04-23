local augroup = require("util.augroup")
local group = augroup("CustomAutocommands")

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
  event = "BufWinEnter",
  callback = function()
    vim.o.statusline =
      [[ %t %m%{&modified?'':'   '} %p%% (%l, %c)%=%{get(b:,'gitsigns_status','')}  %{empty(get(b:,'gitsigns_head',''))?'':'Git '}%{get(b:,'gitsigns_head','')}]]
  end,
})
