local util = require("util")

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.api.nvim_set_keymap("x", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("x", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.api.nvim_set_keymap("x", "<Up>", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("x", "<Down>", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

util.handle_keymaps({
  n = {
    { "<leader>tw", ":set wrap!<cr>" },
    { "<leader>dl", ":messages<cr>" },

    { "<M-r>", util.run_command },
    { "<M-x>", util.run_command_reset },

    -- { "<C-d>", "<C-d>zz" },
    -- { "<C-u>", "<C-u>zz" },

    { "<M-h>", "<C-w>h" },
    { "<M-j>", "<C-w>j" },
    { "<M-k>", "<C-w>k" },
    { "<M-l>", "<C-w>l" },

    { "<M-Left>", "<C-w>h" },
    { "<M-Down>", "<C-w>j" },
    { "<M-Up>", "<C-w>k" },
    { "<M-Right>", "<C-w>l" },

    { "yc", "yygccp" },
  },
  i = {
    { "<M-h>", "<C-[><C-w>h" },
    { "<M-j>", "<C-[><C-w>j" },
    { "<M-k>", "<C-[><C-w>k" },
    { "<M-l>", "<C-[><C-w>l" },

    { "<C-n>", "<cmd>norm j<cr>" },
    { "<C-p>", "<cmd>norm k<cr>" },
  },
  t = {
    { "<M-h>", "<C-\\><C-n><C-w>h" },
    { "<M-j>", "<C-\\><C-n><C-w>j" },
    { "<M-k>", "<C-\\><C-n><C-w>k" },
    { "<M-l>", "<C-\\><C-n><C-w>l" },

    { "<M-Left>",  "<C-\\><C-n><C-w>h" },
    { "<M-Down>",  "<C-\\><C-n><C-w>j" },
    { "<M-Up>",    "<C-\\><C-n><C-w>k" },
    { "<M-Right>", "<C-\\><C-n><C-w>l" },
  },
})
