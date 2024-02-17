(import-macros {: se : hl : au : setup : plug} :macros)

(plug :m-demare/hlargs.nvim {:opts {}})

(plug :justinmk/vim-sneak)

(plug :echasnovski/mini.starter
      {:enabled false :opts {:silent true :header nil :footer ""}})

(plug :miguelcrespo/scratch-buffer.nvim
      {:enabled false
       :dependencies [:Olical/conjure]
       :event :VimEnter
       :opts {:filetype :fennel
              :with_lsp false
              ; :heading "\n"
              :with_neovim_version false}})

(plug :ggandor/flit.nvim {:enabled false :opts {}})

(plug :luukvbaal/statuscol.nvim
      {:enabled false
       :config (fn []
                 (let [statuscol (require :statuscol)]
                   (statuscol.setup)))})

(plug :Olical/conjure {:ft :fennel})

(plug :xiyaowong/virtcolumn.nvim
      {:enabled false
       :config (fn []
                 (se cc 80))})

(plug :okuuva/auto-save.nvim
      {:enabled false
       :opts {:execution_message {:message (fn [] "")}
              :condition (fn [buf]
                           (not= (vim.fn.getbufvar buf :&buftype) :acwrite))}})

(plug :kylechui/nvim-surround {:version "*" :event :VeryLazy :opts {}})
(plug :gpanders/nvim-parinfer)
(plug :jghauser/mkdir.nvim)
(plug :stevearc/oil.nvim
      {:cmd :Oil
       :opts {:columns [; {1 :permissions :highlight :Comment}
                        ; {1 :mtime
                        ;  :highlight :Comment
                        ;  :format "%d %b %H:%M "}
                        :icon]
              :win_options {:signcolumn :yes}}
       :dependencies [:nvim-tree/nvim-web-devicons]})

(plug :ThePrimeagen/harpoon {:lazy true :dependencies [:nvim-lua/plenary.nvim]})

(plug :tpope/vim-repeat)
(plug :tpope/vim-rsi)

(plug :ibhagwan/fzf-lua
      {:enabled true
       :lazy true
       :cmd :FzfLua
       :dependencies [:nvim-tree/nvim-web-devicons]
       :opts {:winopts {:height 10
                        :width 60
                        :preview {:hidden :hidden
                                  :layout :horizontal
                                  :horizontal "right:50%"}
                        :split "bo 10split new"}
              :defaults {:git_icons false
                         :file_icons false
                         :fzf_opts {:--info :inline-right}}
              :files {:fzf_opts {:--header false}}
              :oldfiles {:fd_opts "--exclude '/nvim/runtime/doc/*.txt'"}}})

(plug :folke/which-key.nvim
      {:enabled false
       :event :VeryLazy
       :init (fn [] (se timeout)
               (se timeoutlen 300))
       :opts {:key_labels {:<space> :SPC :<cr> :RET :<tab> :TAB}}})

(plug :folke/neodev.nvim {:lazy true :opts {}})

(plug :folke/trouble.nvim
      {:lazy true
       :opts {:padding false
              :indent_lines false
              :use_diagnostic_signs true
              :icons false
              :fold_open "-"
              :fold_closed "+"}
       :config (fn [_ opts]
                 (setup :trouble opts)
                 (hl TroubleText {:guibg :none})
                 (hl TroubleFoldIcon {:guibg :none}))})

; (plug :nvim-treesitter/nvim-treesitter-context)
(plug :ray-x/go.nvim {:ft :go})

(plug :kevinhwang91/nvim-ufo
      {:lazy true
       :dependencies [:nvim-treesitter/nvim-treesitter
                      :kevinhwang91/promise-async]
       :opts {:provider_selector (fn [] [:treesitter :indent])}})

(plug :nvim-telescope/telescope.nvim
      {:enabled false
       :dependencies [:nvim-lua/plenary.nvim]
       :tag :0.1.5
       :opts {:theme :dropdown}})

(plug :bluz71/vim-moonfly-colors
      {:enabled false
       :priority 1000
       :config (fn [] (vim.cmd.colorscheme :moonfly))})

(plug :ggandor/leap.nvim
      {:enabled false
       :config (fn []
                 ((. (require :leap) :create_default_mappings))
                 (au :User
                     {:pattern :LeapEnter
                      :callback (fn []
                                  (hl Cursor {:blend 100})
                                  (vim.opt.guicursor:append ["a:Cursor/lCursor"]))})
                 (au :User
                     {:pattern :LeapLeave
                      :callback (fn []
                                  (hl Cursor {:blend 0})
                                  (vim.opt.guicursor:remove ["a:Cursor/lCursor"]))}))})

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

(plug :mfussenegger/nvim-lint
      {:config (fn []
                 (let [lint (require :lint)]
                   (set lint.linters_by_ft {:markdown [:vale] :lua [:luacheck]})
                   (vim.api.nvim_create_autocmd [:BufWritePost]
                                                {:callback (fn []
                                                             (lint.try_lint))})))})

(plug :stevearc/conform.nvim
      {:opts {:formatters_by_ft {:lua [:stylua] :fennel [:fnlfmt]}}})

;; fnlfmt: skip
(plug :neovim/nvim-lspconfig
          {:event [:BufReadPre :BufNewFile]
           :dependencies [{1 :williamboman/mason-lspconfig.nvim
                           :dependencies [:williamboman/mason.nvim]}]
           :config (fn []
                     (vim.diagnostic.config {:float {:border :single}})
                     (setup :mason-lspconfig
                            {:handlers [(fn [ls]
                                          (if (= ls :lua_ls) (setup :neodev))
                                          ((. (. (require :lspconfig) ls)
                                              :setup) {:autostart (not= ls :ltex)
                                                       :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
                                                                           :diagnostics {:globals [:vim]}}
                                                                  :Lua {:completion {:completion {:callSnippet :Replace}}
                                                                        :diagnostics {:globals [:vim]}}
                                                                  :ltex {:language :nl
                                                                         :filetype [:norg]
                                                                         :additionalRules {:enablePickyRules true}}}}))]}))})

(plug :williamboman/mason.nvim {:lazy true :opts {:ui {:width 1 :height 1}}})

(plug :numToStr/Comment.nvim {:opts {}})
(plug :HiPhish/rainbow-delimiters.nvim {:enabled false})

(plug :L3MON4D3/LuaSnip
      {:lazy true
       :version :v2.*
       :dependencies [:rafamadriz/friendly-snippets]
       :opts {}
       :config (fn []
                 ((. (require :luasnip.loaders.from_vscode) :lazy_load))
                 ((. (require :luasnip.loaders.from_snipmate) :lazy_load)))
       :build "make install_jsregexp"})

(plug :windwp/nvim-ts-autotag {:event [:BufReadPre :BufNewFile] :opts {}})

(plug :vidocqh/auto-indent.nvim {:opts {}})

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
                                                                    :<CR> (cmp.mapping.confirm {:select true})
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

