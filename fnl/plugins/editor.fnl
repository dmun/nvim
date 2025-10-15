(add :tpope/vim-sleuth)
(add :stevearc/conform.nvim)
(add :stevearc/quicker.nvim)

(let [quicker (require :quicker)]
  (quicker.setup {:opts {:signcolumn :no}}))

(let [conform (require :conform)
      formatters {:qmlformat {:command :qmlformat}}
      formatters_by_ft {:lua [:stylua]
                        :jsonc [:prettier]
                        :nix [:nixfmt]
                        :css [:prettier]
                        :fennel [:fnlfmt]
                        :svelte [:prettier]
                        :javascript [:prettier]
                        :typescript [:prettier]}]
  (conform.setup {: formatters_by_ft : formatters})
  (map :<LocalLeader>f #(conform.format {:lsp_format :fallback})))

;; Lisp
(add :eraserhd/parinfer-rust)
(add :julienvincent/nvim-paredit)
(let [paredit (require :nvim-paredit)]
  (paredit.setup {:indent {:enabled true}}))

;; Pairs
(add :windwp/nvim-autopairs)
(add {:source :saghen/blink.pairs
      :checkout :v0.3.0
      :depends [:saghen/blink.download]})

(let [pairs (require :blink.pairs)
      aup (require :nvim-autopairs)]
  (aup.setup {})
  (pairs.setup {:mappings {:enabled false}})
  (au :BufReadPost "*"
      #(if (not (vim.tbl_contains [:tsx] vim.bo.filetype))
           (set vim.opt_local.winhl
                (.. "BlinkPairsOrange:Delimiter," "BlinkPairsPurple:Delimiter,"
                    "BlinkPairsBlue:Delimiter")))))
