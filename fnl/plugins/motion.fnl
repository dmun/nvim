(import-macros {: se : se+ : se- : hl : au : setup : plug} :macros)

(plug :kylechui/nvim-surround {:version "*" :event :VeryLazy :opts {}})

(plug :tpope/vim-rsi)
(plug :tpope/vim-repeat)

; (plug :justinmk/vim-sneak)

(plug :ggandor/flit.nvim {:opts {:labeled_modes ""}})
(plug :ggandor/leap.nvim
      {:config (fn []
                 ((. (require :leap) :create_default_mappings))
                 (au :User
                     {:pattern :LeapEnter
                      :callback (fn []
                                  (hl Cursor {:blend 100})
                                  (se+ guicursor "a:Cursor/lCursor"))})
                 (au :User
                     {:pattern :LeapLeave
                      :callback (fn []
                                  (hl Cursor {:blend 0})
                                  (se- guicursor "a:Cursor/lCursor"))}))})

