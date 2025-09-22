(import-macros {: au} :macros)

(add :habamax/vim-godot)
(set vim.g.godot_executable :/usr/bin/godot)

(add :nvim-orgmode/orgmode)
(let [orgmode (require :orgmode)]
  (orgmode.setup {:org_agenda_files "~/orgfiles/**/*"
                  :org_default_notes_file "~/orgfiles/refile.org"})
  (au :FileType :org (fn []
                       (set vim.opt_local.number false)
                       (set vim.opt_local.relativenumber false)
                       (vim.cmd "Org indent_mode"))))
