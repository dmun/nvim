(import-macros {: se : hl : au : setup : plug} :macros)

;; fnlfmt: skip
(plug :nvim-treesitter/nvim-treesitter-textobjects
      {:dependencies [:nvim-treesitter/nvim-treesitter]
       :event [:BufReadPre :BufNewFile]
       :config (fn [_ opts]
                 (setup :nvim-treesitter.configs opts))
       :opts {:textobjects {:select {:enable true
                                     :lookahead true
                                     :keymaps {:af "@function.outer"
                                               :if "@function.inner"
                                               :ac "@class.outer"
                                               :ic {:query "@class.inner"
                                                    :desc "Select inner part of a class region"}
                                               :as {:query "@scope"
                                                    :query_group :locals
                                                    :desc "Select language scope"}}
                                     :selection_modes {"@parameter.outer" :v
                                                       "@function.outer" :V
                                                       "@class.outer" :<c-v>}
                                     :include_surrounding_whitespace true}}}})

(plug :nvim-treesitter/nvim-treesitter
      {:build ":TSUpdate"
       :event [:BufReadPre :BufNewFile]
       :config (fn []
                 (local c (require :nvim-treesitter.configs))
                 (c.setup {:highlight {:enable true}
                           :indent {:enable true :disable [:markdown]}
                           :ensure_installed [:lua
                                              :vim
                                              :vimdoc
                                              :luadoc
                                              :norg
                                              :fennel]}))})

; (plug :kevinhwang91/nvim-ufo
;       {:event [:BufReadPre :BufNewFile]
;        :dependencies [:nvim-treesitter/nvim-treesitter
;                       :kevinhwang91/promise-async]
;        :opts {:provider_selector (fn [] [:treesitter :indent])}})

(plug :windwp/nvim-ts-autotag {:event [:BufReadPre :BufNewFile] :opts {}})

(plug :RRethy/vim-illuminate
      {:event [:BufReadPre :BufNewFile]
       :config (fn []
                 (local c (require :illuminate))
                 (c.configure {:filetypes_denylist [:NeogitStatus
                                                    :saga_codeaction
                                                    :Glance]}))})

