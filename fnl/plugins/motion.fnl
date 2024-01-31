(import-macros {: def- : map : remap : cmd : package!} :macros)

;; yank highlight
(let [hi-group (vim.api.nvim_create_augroup :YankHighlight {:clear true})]
  (vim.api.nvim_create_autocmd :TextYankPost
                               {:callback (fn [] (vim.highlight.on_yank)
                                            :group
                                            hi-group
                                            :pattern
                                            "*")}))

;; auto-save
(map :<leader>as (cmd :ASToggle))

;; colorizer
(map :<leader>tc (cmd :ColorizerToggle))

;; fzf-lua
(map :<Leader><Leader> (cmd :FzfLua :files))
(map :<Leader>fr (cmd :FzfLua :oldfiles))
(map :<Leader>/ (cmd :FzfLua :live_grep_resume))
(map :<Leader><LocalLeader> "<CMD>FzfLua buffers<CR>")
(map :<Leader>bi "<CMD>FzfLua builtin<CR>")
(map :<C-l> "<CMD>FzfLua lsp_code_actions<CR>")

;; oil
(map :<leader>e (cmd :bo :Oil))

;; harpoon
(map :<leader>m (cmd :lua "require('harpoon.mark').add_file()"))
(map :<leader>q (cmd :lua "require('harpoon.ui').toggle_quick_menu()"))
(map :<leader>1 (cmd :lua "require('harpoon.ui').nav_file(1)"))
(map :<leader>2 (cmd :lua "require('harpoon.ui').nav_file(2)"))
(map :<leader>3 (cmd :lua "require('harpoon.ui').nav_file(3)"))
(map :<leader>4 (cmd :lua "require('harpoon.ui').nav_file(4)"))

;; nvim-surround
(remap :Q :ysiw)
(remap :M :ysiW)

(macrodebug (package! :miguelcrespo/scratch-buffer.nvim
                      {:event :VimEnter :opts {} :dependencies [:Olical/conjure]}))

(package! :luukvbaal/statuscol.nvim
          {:enabled false
           :config (fn []
                     (let [statuscol (require :statuscol)]
                       (statuscol.setup)))})

(package! :Olical/conjure)
(package! :xiyaowong/virtcolumn.nvim
          {:enabled false
           :config (fn []
                     (def- :cc 80))})

(package! :okuuva/auto-save.nvim {:opts {}})
(package! :kylechui/nvim-surround {:version "*" :event :VeryLazy :opts {}})
(package! :gpanders/nvim-parinfer)
(package! :jghauser/mkdir.nvim)
(package! :stevearc/oil.nvim
          {:opts {} :dependencies [:nvim-tree/nvim-web-devicons]})

(package! :ThePrimeagen/harpoon {:lazy true})
(package! :tpope/vim-repeat)

(package! :ibhagwan/fzf-lua
          {:lazy true
           :cmd :FzfLua
           :dependencies [:nvim-tree/nvim-web-devicons]
           :opts {:winopts {:preview {:hidden :hidden
                                      :layout :horizontal
                                      :horizontal "right:50%"}
                            :split "bo 10split new"}
                  :defaults {:git_icons false
                             :file_icons false
                             :fzf_opts {:--info :inline-right}}
                  :files {:fzf_opts {:--header false}}
                  :oldfiles {:fd_opts "--exclude '/nvim/runtime/doc/*.txt'"}}})
