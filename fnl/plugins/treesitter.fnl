(import-macros {: add} :macros)

(add :nvim-treesitter/nvim-treesitter)
(add :nvim-treesitter/nvim-treesitter-textobjects)
(add :windwp/nvim-ts-autotag)
(add :Wansmer/treesj)

(let [tsa (require :nvim-ts-autotag)]
  (tsa.setup))

(let [ts (require :nvim-treesitter.configs)]
  (ts.setup {:ensure_installed [:lua :vim :vimdoc :query]
             :sync_install false
             :auto_install true
             :indent {:enable true}
             :highlight {:enable true :additional_vim_regex_highlighting false}
             :textobjects {:select {:enable true
                                    :lookahead true
                                    :keymaps {:af "@function.outer"
                                              :if "@function.inner"
                                              :ac "@class.outer"
                                              :ic "@class.inner"}}
                           :incremental_selection {:enable true
                                                   :keymaps {:node_incremental :v
                                                             :node_decremental :V}}}}))

(let [tj (require :treesj)]
  (tj.setup {:use_default_keymaps false})
  (nmap :gJ tj.toggle))

