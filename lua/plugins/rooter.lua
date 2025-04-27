return {
  "airblade/vim-rooter",
  event = "VeryLazy",
  init = function() vim.g.rooter_silent_chdir = 1 end,
}
