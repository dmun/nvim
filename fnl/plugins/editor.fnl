(add :tpope/vim-sleuth)
(add :stevearc/conform.nvim)
(add :stevearc/quicker.nvim)
(let [quicker (require :quicker)]
  (quicker.setup {:opts {:signcolumn :no}}))

(add :eraserhd/parinfer-rust)
(add :julienvincent/nvim-paredit)
(let [paredit (require :nvim-paredit)]
  (paredit.setup {:indent {:enabled true}}))

(add :windwp/nvim-autopairs)
(let [aup (require :nvim-autopairs)]
  (aup.setup {}))

(set vim.g.nvim_ghost_autostart 0)
(add :subnut/nvim-ghost.nvim)
(map :mg vim.cmd.GhostTextStart)

(let [conform (require :conform)
      formatters {:qmlformat {:command :qmlformat}}
      formatters_by_ft {:lua [:stylua]
                        :jsonc [:prettier]
                        :css [:prettier]
                        :fennel [:fnlfmt]
                        :svelte [:prettier]
                        :javascript [:prettier]
                        :typescript [:prettier]}]
  (conform.setup {: formatters_by_ft : formatters})
  (map :mf #(conform.format {:lsp_format :fallback})))

