require("nvim-ts-autotag").setup()

local tj = require("treesj")
tj.setup({ use_default_keymaps = false })
nmap("gJ", tj.toggle)

local ts = require("nvim-treesitter")

require("nvim-treesitter.config").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
  sync_install = false,
})

local ensure_installed = { "lua", "vim", "vimdoc", "query" }
ts.install(ensure_installed)

local ignore_filetype = {}
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local ft = ev.match

    if vim.tbl_contains(ignore_filetype, ft) then
      return
    end

    local lang = vim.treesitter.language.get_lang(ft) or ft
    local buf = ev.buf
    pcall(vim.treesitter.start, buf, lang)

    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v", -- charwise
      ["@function.outer"] = "V", -- linewise
    },
    include_surrounding_whitespace = false,
  },
})

local keymaps = {
  f = "@function",
  c = "@call",
  s = "@assignment",
  a = "@parameter",
  d = "@conditional",
  m = "@statement",
  n = "@number",
  l = "@loop",
}

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

for k, v in pairs(keymaps) do
  vim.keymap.set({ "x", "o" }, "a" .. k, function()
    select.select_textobject(v .. ".outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "i" .. k, function()
    select.select_textobject(v .. ".inner", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "]" .. k, function()
    move.goto_next_start(v .. ".inner", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "[" .. k, function()
    move.goto_previous_start(v .. ".inner", "textobjects")
  end)
  vim.keymap.set("n", "<LocalLeader>s" .. k, function()
    swap.swap_next(v .. ".inner")
  end)
  vim.keymap.set("n", "<LocalLeader>S" .. k, function()
    swap.swap_prev(v .. ".inner")
  end)
end

vim.keymap.set({ "n", "x" }, "s", function()
  move.goto_next_start({
    "@assignment.rhs",
    "@parameter.inner",
    "@statement.inner",
  }, "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "S", function()
  move.goto_previous_start({
    "@assignment.inner",
    "@parameter.inner",
    "@statement.inner",
  }, "textobjects")
end)
