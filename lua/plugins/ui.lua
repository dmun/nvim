return {
  { "crispgm/nvim-tabline", config = true },
  {
    "jake-stewart/auto-cmdheight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      max_lines = 8,
      duration = 2,
      remove_on_key = true,
      clear_always = true,
    },
  },
}
