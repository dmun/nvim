map('n', '<leader>e', [[:lua require'config.tree'.toggle_tree()<CR>]], { silent = true })

vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_hide_dotfiles = 1

vim.g.nvim_tree_icons = {
    default = '',
    git = {
      unstaged = '',
      staged = '',
      unmerged = '',
      renamed = '',
      untracked = '',
      deleted = '',
    },
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
	{ key = "l", cb = tree_cb("edit") },
	{ key = "<TAB>", cb = tree_cb("edit") },
	{ key = "h", cb = tree_cb("close_node") },
	{ key = "<CR>", cb = tree_cb("cd") },
}

local tree = {}
local view_status_ok, view = pcall(require, "nvim-tree.view")
if not view_status_ok then
  return
end
tree.toggle_tree = function()
  if view.win_open() then
    require("nvim-tree").close()
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    if package.loaded["bufferline.state"] then
      -- require'bufferline.state'.set_offset(31, 'File Explorer')
      require("bufferline.state").set_offset(31, "")
    end
    require("nvim-tree").find_file(true)
  end
end

return tree
