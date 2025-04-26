return {
  "kylechui/nvim-surround",
  version = "^3.0.0",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "s",
        normal_cur = "ss",
        -- normal_line = "S",
        normal_cur_line = "S",
        visual = "s",
        visual_line = "S",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
    })
  end,
}
