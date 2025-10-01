(import-macros {: add} :macros)

(add {:source :stevearc/oil.nvim :depends [:echasnovski/mini.icons]})

(let [oil (require :oil)]
  (oil.setup {:win_options {:signcolumn "yes:1"
                            :number false
                            :relativenumber false}
              :preview_win {}
              :keymaps {:<Tab> :actions.select
                        :q :actions.close}})
  (nmap "-" oil.open))

(add {:source :ibhagwan/fzf-lua})
(let [fzf (require :fzf-lua)]
  (fzf.setup {:defaults {:previewer false
                         :file_icons false}
              ; :hls {:cursorline :Visual}
              :fzf_colors {"bg+" [:bg :CursorLine]
                           "fg+" [:fg :Normal]}
              :winopts {:split "belowright new"
                        :title false}})
  (nmap :<Leader>f fzf.files)
  (nmap :<Leader>j fzf.oldfiles)
  (nmap :<Leader>/ fzf.live_grep)
  (nmap :<Leader>h fzf.highlights)
  (nmap :<Leader><Leader> "<Cmd>FzfLua<CR>"))
