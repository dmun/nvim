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
    { "<C-,>", "gccj" },
    { "<leader>dl", ":messages<cr>" },

    { "<leader>mr", util.run_command },
    { "<leader>mR", util.run_command_reset },

    -- { "<C-d>", "<C-d>zz" },
    -- { "<C-u>", "<C-u>zz" },

    { "<C-h>", "<C-w>h" },
    { "<C-j>", "<C-w>j" },
    { "<C-k>", "<C-w>k" },
    { "<C-l>", "<C-w>l" },

    { "<C-Left>", "<C-w>h" },
    { "<C-Down>", "<C-w>j" },
    { "<C-Up>", "<C-w>k" },
    { "<C-Right>", "<C-w>l" },

    { "yc", "yygccp" },

    { "<leader>p", "<cmd>Lazy<cr>" },
  },
  v = {
    { "<C-,>", "gc" },
  },
  i = {
    { "<C-h>", "<C-[><C-w>h" },
    { "<C-j>", "<C-[><C-w>j" },
    { "<C-k>", "<C-[><C-w>k" },
    { "<C-l>", "<C-[><C-w>l" },

    { "<C-Left>", "<C-[><C-w>h" },
    { "<C-Down>", "<C-[><C-w>j" },
    { "<C-Up>", "<C-[><C-w>k" },
    { "<C-Right>", "<C-[><C-w>l" },
  },
  t = {
    { "<C-o>", "<C-\\><C-n>" },
    { "<C-,>", "<C-\\><C-n>" },

    -- { "<C-h>", "<C-\\><C-n><C-w>h" },
    -- { "<C-j>", "<C-\\><C-n><C-w>j" },
    -- { "<C-k>", "<C-\\><C-n><C-w>k" },
    -- { "<C-l>", "<C-\\><C-n><C-w>l" },

    { "<C-Left>", "<C-\\><C-n><C-w>h" },
    { "<C-Down>", "<C-\\><C-n><C-w>j" },
    { "<C-Up>", "<C-\\><C-n><C-w>k" },
    { "<C-Right>", "<C-\\><C-n><C-w>l" },
  },
})
