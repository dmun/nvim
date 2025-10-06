(import-macros {: au} :macros)

(add :habamax/vim-godot)
(set vim.g.godot_executable :/usr/bin/godot)

(add :nvim-orgmode/orgmode)
(let [orgmode (require :orgmode)]
  (orgmode.setup {:org_agenda_files "~/Personal/Notes/**/*"
                  :org_default_notes_file "~/Personal/Notes/refile.org"
                  :org_startup_folded :showeverything
                  :win_split_mode :horizontal
                  :mappings {:disable_all false
                             :org {:org_cycle [:<S-Tab>]
                                   :org_global_cycle false
                                   :org_todo [:<CR>]}}})
  (au :FileType [:org :orgagenda] #(vim.cmd "Org indent_mode")))

(add {:source :saghen/blink.pairs
      :checkout :v0.3.0
      :depends [:saghen/blink.download]})
(let [pairs (require :blink.pairs)]
  (pairs.setup {}))
