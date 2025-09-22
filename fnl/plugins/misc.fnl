(import-macros {: au} :macros)

(add :habamax/vim-godot)
(set vim.g.godot_executable :/usr/bin/godot)

(add :nvim-orgmode/orgmode)
(let [orgmode (require :orgmode)
      treesitter (require :nvim-treesitter.configs)]
  (orgmode.setup {:org_agenda_files "~/orgfiles/**/*"
                  :org_default_notes_file "~/orgfiles/refile.org"})
  (au :BufRead :org #(vim.cmd "Org indent_mode")))

