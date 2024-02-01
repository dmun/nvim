;; (import-macros {: davina : map : remap : cmd : package!} :macros)

(macro def [opt value]
  `(vim.cmd (string.format "set %s=%s" ,opt ,value)))

(macro map [lhs rhs]
  `(vim.keymap.set :n ,lhs ,rhs {:silent true}))

(macro remap [lhs rhs]
  `(vim.keymap.set :n ,lhs ,rhs {:silent true :remap true}))

(macro cmd [command ...]
  `(let [args# (table.concat (icollect [_# v# (ipairs [,...])]
                               (.. " " v#)))]
     (.. :<CMD> ,command (or args# "") :<CR>)))

(macro package! [uri ?opts]
  `(let [spec# (or ,?opts {})]
     (tset spec# 1 ,uri)
     (table.insert _G.packages spec#)))

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
(map :<leader><leader> (cmd :FzfLua :files))
(map :<leader>fr (cmd :FzfLua :oldfiles))
(map :<leader>/ (cmd :FzfLua :live_grep_native))
(map :<leader>? (cmd :FzfLua :live_grep_resume))
(map :<leader><localleader> "<CMD>FzfLua buffers<CR>")
(map :<leader>bi "<CMD>FzfLua builtin<CR>")
(map :<C-l> "<CMD>FzfLua lsp_code_actions<CR>")

;; oil
(map :<leader>e (cmd :Oil))

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

;; hop
(map ";" (cmd :HopLineStart))

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
                     (def :cc 80))})

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
                                      :horizontal "right:50%"}
                            :split "bo 10split new"}
                  :defaults {:git_icons false
                             :file_icons false
                             :fzf_opts {:--info :inline-right}}
                  :files {:fzf_opts {:--header false}}
                  :oldfiles {:fd_opts "--exclude '/nvim/runtime/doc/*.txt'"}}})
