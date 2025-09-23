(import-macros {: au} :macros)

(add :habamax/vim-godot)
(set vim.g.godot_executable :/usr/bin/godot)

(add :nvim-orgmode/orgmode)
(let [orgmode (require :orgmode)]
  (orgmode.setup {:org_agenda_files "~/orgfiles/**/*"
                  :org_default_notes_file "~/orgfiles/refile.org"
                  :mappings {:disable_all false
                             :org {:org_cycle [:<S-Tab>]
                                   :org_global_cycle false
                                   :org_todo [:<CR>]}}})
  (au :FileType [:org :orgagenda] #(vim.cmd "Org indent_mode")))
