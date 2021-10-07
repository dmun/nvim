map('n', '<C-A-l>', ':Format<CR>', { silent = true })

require('formatter').setup({
  filetype = {
    haskell = {
      function()
        return {
          exe = "brittany",
          args = { "--indent=4" },
          stdin = true
        }
      end
    },
  }
})
