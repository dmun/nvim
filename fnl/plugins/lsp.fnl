(import-macros {: se : hl : au : setup : plug} :macros)

(plug :mrcjkb/rustaceanvim {:version :^4 :ft :rust})

;; fnlfmt: skip
(plug :neovim/nvim-lspconfig
          {:event [:BufReadPre :BufNewFile]
           :dependencies [{1 :williamboman/mason-lspconfig.nvim
                           :dependencies [:williamboman/mason.nvim]}]
           :config (fn []
                     (vim.diagnostic.config {:virtual_text true
                                             :float {:border false}})
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

(plug :mfussenegger/nvim-lint
      {:config (fn []
                 (let [lint (require :lint)]
                   (set lint.linters_by_ft {:lua [:luacheck]})
                   (vim.api.nvim_create_autocmd [:BufWritePost]
                                                {:callback (fn []
                                                             (lint.try_lint))})))})

(plug :stevearc/conform.nvim
      {:opts {:formatters_by_ft {:lua [:stylua]
                                 :fennel [:fnlfmt]
                                 :rust [:rustfmt]}}})

(plug :williamboman/mason.nvim {:lazy true :opts {:ui {:width 1 :height 1}}})

(plug :numToStr/Comment.nvim {:opts {}})

(plug :vidocqh/auto-indent.nvim {:opts {}})

(plug :ray-x/go.nvim {:ft :go})
(plug :folke/trouble.nvim
      {:lazy true
       :cmd :TroubleToggle
       :opts {:padding false
              :indent_lines false
              :use_diagnostic_signs true
              :icons false
              :fold_open "-"
              :fold_closed "+"}
       :config (fn [_ opts]
                 (setup :trouble opts)
                 (hl TroubleText {:bg :none})
                 (hl TroubleFoldIcon {:bg :none}))})

(plug :folke/neodev.nvim {:lazy true :opts {}})
(plug :Olical/conjure {:ft :fennel})
(plug :gpanders/nvim-parinfer)
(plug :m-demare/hlargs.nvim {:opts {}})
; (plug :HiPhish/rainbow-delimiters.nvim)

