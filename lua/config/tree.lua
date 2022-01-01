map('n', '<leader>e', [[:lua require'config.tree'.toggle_tree()<CR>]], { silent = true })

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  hijack_cursor       = true,
  update_cwd          = true,
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },

  view = {
    width = 30,
    height = 30,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {
          { key = { "<TAB>", "l" }, cb = tree_cb("edit") },
          { key = { "h" }, cb = tree_cb("close_node") },
          { key = { "<CR>" }, cb = tree_cb("cd") },
      }
    }
  }
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
    require("nvim-tree").open()
  end
end

return tree
