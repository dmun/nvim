(import-macros {: se : hl : au : setup : plug} :macros)

(plug :nvim-treesitter/nvim-treesitter-context)

(plug :nvim-treesitter/nvim-treesitter
      {:event [:BufReadPre :BufNewFile]
       :build ":TSUpdate"
       :config (fn []
                 (let [configs (require :nvim-treesitter.configs)]
                   (configs.setup {:highlight {:enable true}
                                   :indent {:enable true}
                                   :ensure_installed [:lua
                                                      :vim
                                                      :vimdoc
                                                      :luadoc
                                                      :norg
                                                      :fennel]})))})

; (plug :kevinhwang91/nvim-ufo
;       {:event [:BufReadPre :BufNewFile]
;        :dependencies [:nvim-treesitter/nvim-treesitter
;                       :kevinhwang91/promise-async]
;        :opts {:provider_selector (fn [] [:treesitter :indent])}})

(plug :windwp/nvim-ts-autotag {:event [:BufReadPre :BufNewFile] :opts {}})

