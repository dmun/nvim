(import-macros {: se : hl : au : setup : plug} :macros)

(plug :windwp/nvim-autopairs {:config true})
(plug :airblade/vim-rooter)
(plug :jghauser/mkdir.nvim)
(plug :ThePrimeagen/harpoon {:lazy true} :dependencies [:nvim-lua/plenary.nvim])

(plug :stevearc/oil.nvim
      {:cmd :Oil
       :opts {:win_options {:signcolumn :yes}}
       :dependencies [:nvim-tree/nvim-web-devicons]})

(plug :ibhagwan/fzf-lua
      {:enabled true
       :lazy true
       :cmd :FzfLua
       :dependencies [:nvim-tree/nvim-web-devicons]
       :opts {:winopts {:height 20
                        :border :single}
              :defaults {:git_icons false
                         :file_icons false
                         :fzf_opts {:--info :inline-right}}
              :files {:fzf_opts {:--header false}}
              :oldfiles {:fd_opts "--exclude '/nvim/runtime/doc/*.txt'"}}
       :config (fn [_ opts]
                 (setup :fzf-lua opts)
                 (hl FzfLuaHeaderBind "@punctuation")
                 (hl FzfLuaBorder Comment)
                 (hl FzfLuaCursorlineNr Normal)
                 (hl FzfLuaCursorline Normal)
                 (hl FzfLuaTitle "@text.title")
                 (hl FzfLuaHeaderText "@constant"))})

; (plug :nvim-telescope/telescope.nvim
;       {:cmd :Telescope
;        :module :telescope
;        :tag :0.1.6
;        :dependencies [:nvim-lua/plenary.nvim]
;        :opts {:defaults (get-dropdown {:mappings {:i {:<ESC> :close
;                                                       :<C-d> :delete_buffer}}})}})

