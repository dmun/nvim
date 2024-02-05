(import-macros {: set-
                : setg-
                : nmap
                : imap
                : vmap
                : remap
                : cmd
                : hl
                : setup
                : package!} :macros)

(macro set- [opt value]
  (tset `vim.o opt value))

(macro setg- [opt value]
  (tset `vim.g opt value))

(macro map [mode lhs rhs]
  `(vim.keymap.set ,mode ,lhs ,rhs {:silent true}))

(macro nmap [lhs rhs]
  `(map :n ,lhs ,rhs))

(macro imap [lhs rhs]
  `(map :i ,lhs ,rhs))

(macro vmap [lhs rhs]
  `(map :v ,lhs ,rhs))

(macro remap [lhs rhs]
  `(vim.keymap.set :n ,lhs ,rhs {:silent true :remap true}))

(macro cmd [command ...]
  `(let [args# (table.concat (icollect [_# v# (ipairs [,...])]
                               (.. " " v#)))]
     (.. :<CMD> ,command (or args# "") :<CR>)))

(macro hl [group opts]
  `(let [opts# (icollect [k# v# (pairs ,opts)]
                 (string.format "%s=%s" k# v#))]
     (vim.cmd.highlight ,group (.. (unpack opts#)))))

(macro setup [package opts]
  `(let [module# (require ,package)]
     (module#.setup ,opts)))

(macro package! [uri ?opts]
  `(let [spec# (or ,?opts {})]
     (tset spec# 1 ,uri)
     (table.insert _G.packages spec#)))

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
(nmap :<leader><localleader> "<CMD>FzfLua buffers<CR>")
(nmap :<leader>bi "<CMD>FzfLua builtin<CR>")
(nmap :<C-l> "<CMD>FzfLua lsp_code_actions<CR>")

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
(remap :Q :ysiw)
(remap :M :ysiW)

;; hop
(nmap ";" :<CMD>HopLineStart<CR>)
(vmap ";" :<CMD>HopLineStart<CR>)

;; mason
; (nmap :<leader>m ":Mason<CR>")

(package! :miguelcrespo/scratch-buffer.nvim
          {:enabled false
           :dependencies [:Olical/conjure]
           :event :VimEnter
           :opts {:filetype :fennel
                  :with_lsp false
                  ; :heading "\n"
                  :with_neovim_version false}})

(package! :ggandor/flit.nvim {:opts {}})
(package! :smoka7/hop.nvim {:opts {}})

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
          {:opts {:condition (fn [buf]
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

(package! :ibhagwan/fzf-lua
          {:lazy true
           :cmd :FzfLua
           :dependencies [:nvim-tree/nvim-web-devicons]
           :opts {:winopts {:height 10
                            :width 60
                            :preview {:hidden :hidden
                                      :layout :horizontal
                                      :horizontal "right:50%"}}
                  ; :split "bo split new"}
                  :defaults {:git_icons false
                             :file_icons false
                             :fzf_opts {:--info :inline-right}}
                  :files {:fzf_opts {:--header false}}
                  :oldfiles {:fd_opts "--exclude '/nvim/runtime/doc/*.txt'"}}})

(package! :folke/which-key.nvim
          {:event :VeryLazy
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

(package! :nvim-treesitter/nvim-treesitter-context)
(package! :ray-x/go.nvim)
(package! :kevinhwang91/nvim-ufo
          {:dependencies [:kevinhwang91/promise-async]
           :opts {:provider_selector (fn [] [:treesitter :indent])}})
