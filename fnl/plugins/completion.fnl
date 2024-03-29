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

(fn whitespace [n]
  (if (> n 0)
      (.. " " (whitespace (- n 1)))
      ""))

(fn format-menu [entry item]
  (set item.abbr (.. " " (string.gsub item.abbr "%s+" "")))
  (if item.menu
      (let [len (+ (length item.abbr) (length item.menu))]
        (set item.abbr (.. item.abbr (whitespace (- 38 len)) "  " item.menu))))
  (set item.menu "")
  item)

(fn cmp-formatting [lspkind]
  {:fields [:kind :abbr :menu]
   :format (lspkind.cmp_format {:mode :symbol
                                :maxwidth 40
                                :ellipsis_char "…"
                                :show_labelDetails true
                                :before format-menu})})

(fn cmp-mapping [cmp luasnip]
  {:<C-k> (cmp.mapping.scroll_docs -4)
   :<C-j> (cmp.mapping.scroll_docs 4)
   :<C-Space> (cmp.mapping.complete)
   :<C-c> (cmp.mapping.abort)
   :<C-n> (cmp.mapping.select_next_item)
   :<C-p> (cmp.mapping.select_prev_item)
   :<TAB> (cmp.mapping (fn [fallback]
                         (if (cmp.visible) (cmp.confirm {:select true})
                             (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
                             (fallback))) [:i :s])
   :<S-TAB> (cmp.mapping (fn [fallback]
                           (if (luasnip.jumpable -1)
                               (luasnip.jump -1)
                               (fallback))) [:i :s])})

(fn cmp-setup [cmp luasnip lspkind]
  (cmp.setup {:snippet {:expand (fn [args]
                                  (luasnip.lsp_expand args.body))}
              :mapping (cmp-mapping cmp luasnip)
              :completion {:completeopt "menu,menuone"}
              :preselect cmp.PreselectMode.None
              :experimental {:ghost_text true}
              :sources (cmp.config.sources [{:name :conjure}
                                            {:name :nvim_lsp}
                                            {:name :luasnip}
                                            {:name :path}
                                            {:name :nvim_lua}
                                            {:name :nvim_lsp_signature_help}
                                            {:name :buffer}])
              :sorting {:comparators [cmp.config.compare.locality
                                      cmp.config.compare.recently_used
                                      cmp.config.compare.score
                                      cmp.config.compare.offset
                                      (. (require :cmp-under-comparator) :under)
                                      cmp.config.compare.order]}
              :window {:completion {:col_offset -3}}
              :formatting (cmp-formatting lspkind)}))

(plug :hrsh7th/nvim-cmp
      {:version false
       :event :InsertEnter
       :dependencies [:hrsh7th/cmp-buffer
                      :hrsh7th/cmp-path
                      :hrsh7th/cmp-nvim-lua
                      :hrsh7th/cmp-nvim-lsp
                      :hrsh7th/cmp-nvim-lsp-signature-help
                      :PaterJason/cmp-conjure
                      :lukas-reineke/cmp-under-comparator
                      {1 :saadparwaiz1/cmp_luasnip
                       :dependencies [:L3MON4D3/LuaSnip]}]
       :config (fn []
                 (cmp-setup (require :cmp) (require :luasnip)
                            (require :lspkind)))})

