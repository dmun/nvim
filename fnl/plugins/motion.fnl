;; (import-macros {: davina : map : remap : cmd : package!} :macros)

(macro set- [opt value]
  `(tset vim.o ,opt ,value))

(macro setg- [opt value]
  `(tset vim.g ,opt ,value))

(macro map [lhs rhs]
  `(vim.keymap.set :n ,lhs ,rhs {:silent true}))

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

;; sets
; (setg- "conjure#mapping#doc_word" false)
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

; (vim.api.nvim_create_autocmd :FileType
;                              {:pattern :fzf
;                               :callback (fn []
;                                           (set- :laststatus 0)
;                                           (set- :showmode false)
;                                           (set- :ruler false))})
;
; (vim.api.nvim_create_autocmd :BufLeave
;                              {:buffer (vim.fn.bufnr)
;                               :callback (fn []
;                                           (set- :laststatus 2)
;                                           (set- :showmode true)
;                                           (set- :ruler true))})

;; auto-save
(map :<leader>as (cmd :ASToggle))

;; colorizer
(map :<leader>tc (cmd :ColorizerToggle))

;; fzf-lua
(map :<leader><leader> (cmd :FzfLua :files))
(map :<leader>fr (cmd :FzfLua :oldfiles))
(map :<leader>/ (cmd :FzfLua :live_grep_native))
(map :<leader>? (cmd :FzfLua :live_grep_resume))
(map :<leader><localleader> "<CMD>FzfLua buffers<CR>")
(map :<leader>bi "<CMD>FzfLua builtin<CR>")
(map :<C-l> "<CMD>FzfLua lsp_code_actions<CR>")

;; oil
(map :<leader>e ":Oil<CR>")

;; harpoon
(map :<leader>m ":lua require('harpoon.mark').add_file()<CR>")
(map :<leader>q ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
(map :<leader>1 ":lua require('harpoon.ui').nav_file(1)<CR>")
(map :<leader>2 ":lua require('harpoon.ui').nav_file(2)<CR>")
(map :<leader>3 ":lua require('harpoon.ui').nav_file(3)<CR>")
(map :<leader>4 ":lua require('harpoon.ui').nav_file(4)<CR>")

;; nvim-surround
(remap :Q :ysiw)
(remap :M :ysiW)

;; hop
(map ";" ":HopLineStart<CR>")

;; mason
(map :<leader>m ":Mason<CR>")

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

(package! :okuuva/auto-save.nvim {:opts {}})
(package! :kylechui/nvim-surround {:version "*" :event :VeryLazy :opts {}})
(package! :gpanders/nvim-parinfer)
(package! :jghauser/mkdir.nvim)
(package! :stevearc/oil.nvim
          {:opts {:columns [; {1 :permissions :highlight :Comment}
                            {1 :mtime
                             :highlight :Comment
                             :format "%d %b %H:%M "}
                            :icon]
                  :win_options {:signcolumn :yes}}
           :dependencies [:nvim-tree/nvim-web-devicons]})

(package! :ThePrimeagen/harpoon {:lazy true})
(package! :tpope/vim-repeat)

(package! :ibhagwan/fzf-lua
          {:lazy true
           :cmd :FzfLua
           :dependencies [:nvim-tree/nvim-web-devicons]
           :opts {:winopts {:preview {:hidden :hidden
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
