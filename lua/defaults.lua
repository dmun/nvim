-- Load .vimrc.
vim.cmd "source $HOME/.config/nvim/.vimrc"

-- Highlight on yank.
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- Choose colorscheme.
vim.cmd "color catppuccin"

-- Add support for commandline color
-- vim.cmd "hi NormalBuffer guibg=#2B353C"
-- vim.cmd "hi Normal guibg=#212A2E"
-- vim.cmd "autocmd BufEnter * if &bt != 'nofile' | setlocal winhl=Normal:NormalBuffer"

vim.fn.sign_define("DiagnosticSignError",
    { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
    { text = "󰌵", texthl = "DiagnosticSignHint" })
