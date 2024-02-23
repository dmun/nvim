(import-macros {: se : hl : au : setup : plug} :macros)

(plug "airblade/vim-rooter")

(plug :jghauser/mkdir.nvim)

(plug :ThePrimeagen/harpoon {:lazy true} :dependencies [:nvim-lua/plenary.nvim])

(plug :stevearc/oil.nvim
      {:cmd :Oil
       :opts {:columns [; {1 :permissions :highlight :Comment}
                        ; {1 :mtime
                        ;  :highlight :Comment
                        ;  :format "%d %b %H:%M "}
                        :icon]
              :win_options {:signcolumn :yes}}
       :dependencies [:nvim-tree/nvim-web-devicons]})

(plug :ibhagwan/fzf-lua
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

