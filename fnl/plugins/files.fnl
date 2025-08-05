(import-macros {: add} :macros)

(add {:source :stevearc/oil.nvim :depends [:echasnovski/mini.icons]})

(let [oil (require :oil)]
  (oil.setup {:preview_win {}
              :win_options {:signcolumn :yes}
              :keymaps {:<Tab> :actions.select
                        :q :actions.close}})
  (nmap "-" oil.open))

