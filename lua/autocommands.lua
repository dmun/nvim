-- filetypes
vim.cmd("au BufRead,BufEnter *.swiftinterface se ft=swift")
vim.cmd("au BufRead,BufEnter .swift-format se ft=json")
vim.cmd("au BufRead,BufEnter *.dagitty se ft=luau")
vim.cmd("au BufRead,BufEnter *.metal se ft=metal")
vim.cmd("au BufRead,BufEnter config se ft=conf")

-- highlight on yank
local hi_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = hi_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

local fts = {
  "copilot-chat",
  "copilot-diff",
  "copilot-overlay",
  "oil",
}

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = function()
    if vim.tbl_contains(fts, vim.bo.ft) then
      -- vim.opt_local.winhl = "Normal:NormalFloat"
      vim.opt_local.relativenumber = false
      vim.opt_local.number = false
      vim.opt_local.signcolumn = "no"
    end
  end,
})

-- dynamic linenumbers
-- vim.cmd("au InsertEnter * if &nu | se nornu | endif")
-- vim.cmd("au InsertLeave * if &nu | se rnu | endif")
