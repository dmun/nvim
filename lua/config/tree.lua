map('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })

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
