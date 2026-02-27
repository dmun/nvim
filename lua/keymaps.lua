vim.g.mapleader = " "
vim.g.maplocalleader = "m"

local function toggle(...)
  local options = { ... }
  for _, option in ipairs(options) do
    vim.o[option] = not vim.o[option]
  end
end

--
-- General
--

nmap("<Esc>", function()
  if vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 1 then
    vim.cmd("silent update")
  end
  vim.cmd("nohl | echo")
end)

nmap("K", function()
  vim.cmd.help(vim.fn.expand("<cword>"))
end)

imap("<C-n>", "<Down>")
imap("<C-p>", "<Up>")

nmap("<Leader>m", "m")
nmap("<Leader>i", vim.cmd.Inspect)

-- j/k movement when hard-wrapping
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

nmap("<C-;>", "gccj", { remap = true })
xmap("<C-;>", "gc", { remap = true })

--
-- Files
--

-- Finders
nmap("<Leader>f", ":find ")
nmap("g/", ":grep  | copen" .. vim.fn["repeat"]("<Left>", 8))
vim.keymap.set("!", "<C-Enter>", "<Esc>:vimgrep // % | copen<CR>")

-- Yanking
nmap("yr", 'ggVG"+y<C-o>')
nmap("yc", "yygccp", { remap = true })

-- Copy to system clipboard
vim.keymap.set({ "n", "x" }, "<Leader>p", '"+p')
vim.keymap.set({ "n", "x" }, "<Leader>y", '"+y')

-- (c)hange (o)ption
nmap("cow", function()
  toggle("wrap")
end)
nmap("con", function()
  toggle("nu", "rnu")
end)
nmap("cos", function()
  if vim.wo.scl ~= "no" then
    vim.wo.scl = "no"
  else
    vim.wo.scl = "yes"
  end
end)
