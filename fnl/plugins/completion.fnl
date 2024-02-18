(import-macros {: se : hl : au : setup : plug} :macros)

(plug :L3MON4D3/LuaSnip
      {:lazy true
       :version :v2.*
       :dependencies [:rafamadriz/friendly-snippets]
       :opts {}
       :config (fn []
                 ((. (require :luasnip.loaders.from_vscode) :lazy_load))
                 ((. (require :luasnip.loaders.from_snipmate) :lazy_load)))
       :build "make install_jsregexp"})

(plug :hrsh7th/nvim-cmp
      {:event :InsertEnter
       :dependencies [:hrsh7th/cmp-buffer
                      :hrsh7th/cmp-nvim-lua
                      :hrsh7th/cmp-nvim-lsp
                      :hrsh7th/cmp-nvim-lsp-signature-help
                      :PaterJason/cmp-conjure
                      :lukas-reineke/cmp-under-comparator
                      {1 :saadparwaiz1/cmp_luasnip
                       :dependencies [:L3MON4D3/LuaSnip]}]
       :config (fn []
                 (let [cmp (require :cmp)
                       luasnip (require :luasnip)]
                   (cmp.setup {:snippet {:expand (fn [args]
                                                   (luasnip.lsp_expand args.body))}
                               :mapping (cmp.mapping.preset.insert {:<C-b> (cmp.mapping.scroll_docs -4)
                                                                    :<C-f> (cmp.mapping.scroll_docs 4)
                                                                    :<C-Space> (cmp.mapping.complete)
                                                                    :<C-e> (cmp.mapping.abort)
                                                                    ; :<CR> (cmp.mapping.confirm {:select true})
                                                                    :<TAB> (cmp.mapping.confirm {:select true})})
                               :completion {:completeopt "menu,menuone"}
                               :preselect cmp.PreselectMode.None
                               :experimental {:ghost_text true}
                               :sources (cmp.config.sources [{:name :conjure}
                                                             {:name :luasnip}
                                                             {:name :nvim_lsp}
                                                             {:name :nvim_lua}
                                                             {:name :nvim_lsp_signature_help}
                                                             {:name :buffer}])
                               :sorting {:comparators [cmp.config.compare.offset
                                                       cmp.config.compare.kind
                                                       cmp.config.compare.exact
                                                       cmp.config.compare.score
                                                       (. (require :cmp-under-comparator)
                                                          :under)
                                                       cmp.config.compare.sort_text
                                                       cmp.config.compare.length
                                                       cmp.config.compare.order]}})))})
