-- filetypes
vim.cmd("au BufRead,BufEnter *.swiftinterface se ft=swift")
vim.cmd("au BufRead,BufEnter .swift-format se ft=json")
vim.cmd("au BufRead,BufEnter *.dagitty se ft=luau")

-- highlight on yank
local hi_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = hi_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- terminal
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.o.ft = "terminal"
      vim.opt_local.winhl = "Normal:NormalTerm,SignColumn:NormalTerm"
      vim.opt_local.relativenumber = false
      vim.opt_local.number = false
      -- vim.opt_local.signcolumn = "no"
      vim.cmd.normal("i")
    end
  end,
})

-- dynamic linenumbers
vim.cmd("au InsertEnter * se nornu")
vim.cmd("au InsertLeave * se rnu")
