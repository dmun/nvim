(import-macros {: set- : setg- : nmap : cmd : hl : setup : package!} :macros)

(setg- "conjure#filetypes" [:clojure
                            :fennel
                            :janet
                            :hy
                            :julia
                            :racket
                            :scheme
                            ; :lua
                            :lisp
                            :python
                            :rust
                            :sql])

;; yank highlight
(let [hi-group (vim.api.nvim_create_augroup :YankHighlight {:clear true})]
  (vim.api.nvim_create_autocmd :TextYankPost
                               {:callback (fn [] (vim.highlight.on_yank)
                                            :group
                                            hi-group
                                            :pattern
                                            "*")}))

;; auto-save
(nmap :<leader>as ":ASToggle<CR>")

;; colorizer
(nmap :<leader>tc (cmd :ColorizerToggle))

;; fzf-lua
(nmap :<leader><leader> (cmd :FzfLua :files))
(nmap :<leader>fr (cmd :FzfLua :oldfiles))
(nmap :<leader>/ (cmd :FzfLua :live_grep_native))
(nmap :<leader>? (cmd :FzfLua :live_grep_resume))
(nmap "<leader>," "<CMD>FzfLua buffers<CR>")
(nmap :<leader>bi "<CMD>FzfLua builtin<CR>")
(nmap :<M-x> "<CMD>FzfLua commands<CR>")
(nmap :<leader>ca "<CMD>FzfLua lsp_code_actions<CR>")

;; telescope
; (nmap :<leader><leader> "<CMD>Telescope find_files<CR>")
; (nmap :<leader>fr "<CMD>Telescope oldfiles<CR>")
; (nmap :<leader>/ "<CMD>Telescope live_grep<CR>")
; (nmap "<leader>," "<CMD>Telescope buffers<CR>")
; (nmap :<leader>bi :<CMD>Telescope<CR>)
; (nmap :<C-l> "<CMD>FzfLua lsp_code_actions<CR>")

;; oil
(nmap :<leader>e ":Oil<CR>")

;; harpoon
(nmap :<leader>m ":lua require('harpoon.mark').add_file()<CR>")
(nmap :<leader>q ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
(nmap :<leader>1 ":lua require('harpoon.ui').nav_file(1)<CR>")
(nmap :<leader>2 ":lua require('harpoon.ui').nav_file(2)<CR>")
(nmap :<leader>3 ":lua require('harpoon.ui').nav_file(3)<CR>")
(nmap :<leader>4 ":lua require('harpoon.ui').nav_file(4)<CR>")

;; nvim-surround
; (remap :Q :ysiw)
; (remap :M :ysiW)

;; hop
; (nmap ";" :<CMD>HopLineStart<CR>)
; (vmap ";" :<CMD>HopLineStart<CR>)

;; mason
; (nmap :<leader>m ":Mason<CR>")

(nmap :f :<Plug>Sneak_f)
(nmap :F :<Plug>Sneak_F)
(nmap :t :<Plug>Sneak_t)
(nmap :T :<Plug>Sneak_T)

(package! :justinmk/vim-sneak)

(package! :miguelcrespo/scratch-buffer.nvim
          {:enabled false
           :dependencies [:Olical/conjure]
           :event :VimEnter
           :opts {:filetype :fennel
                  :with_lsp false
                  ; :heading "\n"
                  :with_neovim_version false}})

(package! :ggandor/flit.nvim {:enabled false :opts {}})
; (package! :smoka7/hop.nvim {:opts {}})

(package! :luukvbaal/statuscol.nvim
          {:enabled false
           :config (fn []
                     (let [statuscol (require :statuscol)]
                       (statuscol.setup)))})

(package! :Olical/conjure)

(package! :xiyaowong/virtcolumn.nvim
          {:enabled false
           :config (fn []
                     (set- :cc 80))})

(package! :okuuva/auto-save.nvim
          {:enabled false
           :opts {:execution_message {:message (fn [] "")}
                  :condition (fn [buf]
                               (not= (vim.fn.getbufvar buf :&buftype) :acwrite))}})

(package! :kylechui/nvim-surround {:version "*" :event :VeryLazy :opts {}})
(package! :gpanders/nvim-parinfer)
(package! :jghauser/mkdir.nvim)
(package! :stevearc/oil.nvim
          {:opts {:columns [; {1 :permissions :highlight :Comment}
                            ; {1 :mtime
                            ;  :highlight :Comment
                            ;  :format "%d %b %H:%M "}
                            :icon]
                  :win_options {:signcolumn :yes}}
           :dependencies [:nvim-tree/nvim-web-devicons]})

(package! :ThePrimeagen/harpoon
          {:lazy true :dependencies [:nvim-lua/plenary.nvim]})

(package! :tpope/vim-repeat)
(package! :tpope/vim-rsi)

(package! :ibhagwan/fzf-lua
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

(package! :folke/which-key.nvim
          {:enabled false
           :event :VeryLazy
           :init (fn [] (set- :timeout true)
                   (set- :timeoutlen 300))
           :opts {:key_labels {:<space> :SPC :<cr> :RET :<tab> :TAB}}})

(package! :folke/neodev.nvim {:opts {}})

(package! :folke/trouble.nvim
          {:lazy true
           :opts {:padding false
                  :indent_lines false
                  :use_diagnostic_signs true
                  :icons false
                  :fold_open "-"
                  :fold_closed "+"}
           :config (fn [_ opts]
                     (setup :trouble opts)
                     (hl :TroubleText {:guibg :none})
                     (hl :TroubleFoldIcon {:guibg :none}))})

; (package! :nvim-treesitter/nvim-treesitter-context)
(package! :ray-x/go.nvim)
(package! :bakpakin/fennel.vim)

(package! :kevinhwang91/nvim-ufo
          {:dependencies [:nvim-treesitter/nvim-treesitter
                          :kevinhwang91/promise-async]
           :opts {:provider_selector (fn [] [:treesitter :indent])}})

(package! :nvim-telescope/telescope.nvim
          {:enabled false
           :dependencies [:nvim-lua/plenary.nvim]
           :tag :0.1.5
           :opts {:theme :dropdown}})

(macro au [group opts]
  `(vim.api.nvim_create_autocmd ,group ,opts))

(package! :bluz71/vim-moonfly-colors
          {:enabled false
           :priority 1000
           :config (fn [] (vim.cmd.colorscheme :moonfly))})

(package! :ggandor/leap.nvim
          {:enabled false
           :config (fn []
                     ((. (require :leap) :create_default_mappings))
                     (au :User
                         {:pattern :LeapEnter
                          :callback (fn []
                                      (hl :Cursor {:blend 100})
                                      (vim.opt.guicursor:append ["a:Cursor/lCursor"]))})
                     (au :User
                         {:pattern :LeapLeave
                          :callback (fn []
                                      (hl :Cursor {:blend 0})
                                      (vim.opt.guicursor:remove ["a:Cursor/lCursor"]))}))})

(hl :Sneak {:guifg "#FF007C" :gui "underline,nocombine"})

(package! :nvim-treesitter/nvim-treesitter
          {:event [:BufReadPre :BufNewFile]
           :opts {:highlight {:enable true}
                  :indent {:enable true}
                  :ensure_installed [:lua :vim :vimdoc :luadoc :norg :fennel]}})

(package! :mfussenegger/nvim-lint
          {:config (fn []
                     (let [lint (require :lint)]
                       (set lint.linters_by_ft
                            {:markdown [:vale] :lua [:luacheck]})
                       (vim.api.nvim_create_autocmd [:BufWritePost]
                                                    {:callback (fn []
                                                                 (lint.try_lint))})))})

(package! :stevearc/conform.nvim
          {:opts {:formatters_by_ft {:lua [:stylua] :fennel [:fnlfmt]}}})

;; fnlfmt: skip
(package! :neovim/nvim-lspconfig
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

(package! :williamboman/mason.nvim {:opts {:ui {:width 1 :height 1}}})
(package! :numToStr/Comment.nvim {:opts {}})
(package! :HiPhish/rainbow-delimiters.nvim {:enabled false})

(package! :L3MON4D3/LuaSnip
          {:lazy true
           :version :v2.*
           :dependencies [:rafamadriz/friendly-snippets]
           :opts {}
           :config (fn []
                     ((. (require :luasnip.loaders.from_vscode) :lazy_load))
                     ((. (require :luasnip.loaders.from_snipmate) :lazy_load)))
           :build "make install_jsregexp"})

(package! :windwp/nvim-ts-autotag {:event [:BufReadPre :BufNewFile] :opts {}})

(package! :vidocqh/auto-indent.nvim {:opts {}})

(package! :hrsh7th/nvim-cmp
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
                                                                        :<CR> (cmp.mapping.confirm {:select true})})
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

