(import-macros {: se : hl : au : setup : plug} :macros)

; (plug :nvim-telescope/telescope.nvim
;       {:cmd :Telescope
;        :module :telescope
;        :tag :0.1.6
;        :dependencies [:nvim-lua/plenary.nvim]
;        :opts {:defaults (get-dropdown {:mappings {:i {:<ESC> :close
;                                                       :<C-d> :delete_buffer}}})}})

(plug :windwp/nvim-autopairs {:config true})
(plug :airblade/vim-rooter)
(plug :jghauser/mkdir.nvim)
(plug :ThePrimeagen/harpoon {:lazy true} :dependencies [:nvim-lua/plenary.nvim])

(plug :stevearc/oil.nvim
      {:cmd :Oil
       :opts {:columns [; {1 :permissions :highlight :Comment}
                        ; {1 :mtime
                        ;  :highlight :Comment
                        ;  :format "%d %b %H:%M "}
                        :icon]
              :keymaps {:<C-p> false}
              :win_options {:signcolumn :yes}}
       :dependencies [:nvim-tree/nvim-web-devicons]})

(plug :ibhagwan/fzf-lua
      {:enabled true
       :lazy true
       :cmd :FzfLua
       :dependencies [:nvim-tree/nvim-web-devicons]
       :opts {:winopts {:height 20}
                        ; :width 60}
                        ; :preview {:hidden :hidden
                        ;           :layout :horizontal
                        ;           :horizontal "right:50%"}}
              ; :split "bo 10split new"}
              :defaults {:git_icons false
                         :file_icons false
                         :fzf_opts {:--info :inline-right}}
              :files {:fzf_opts {:--header false}}
              :oldfiles {:fd_opts "--exclude '/nvim/runtime/doc/*.txt'"}}})

