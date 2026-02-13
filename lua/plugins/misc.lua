vim.g.godot_executable = "/usr/bin/godot"

require("orgmode").setup({
  org_agenda_files = "~/Cloud Drive/notes/**/*",
  org_default_notes_file = "~/Cloud Drive/notes",
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
