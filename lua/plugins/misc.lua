-- add("habamax/vim-godot")
vim.g.godot_executable = "/usr/bin/godot"

-- add("nvim-orgmode/orgmode")
require("orgmode").setup({
  org_agenda_files = "~/orgfiles/**/*",
  org_default_notes_file = "~/orgfiles/refile.org",
  org_startup_folded = "showeverything",
  win_split_mode = "horizontal",
  mappings = {
    disable_all = false,
    org = {
      org_cycle = { "<S-Tab>" },
      org_global_cycle = false,
      org_todo = { "<CR>" },
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "org", "orgagenda" },
  callback = function()
    vim.cmd("Org indent_mode")
  end,
})
