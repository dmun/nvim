(import-macros {: se : se+ : setg : sign} :macros)

;; global options
(setg rooter_silent_chdir 1)
(setg sneak#use_ic_scs 1)
(setg sneak#s_next 1)
(setg tex_flavor :latex)
(setg rustaceanvim
    {:tools {:hover_actions {:replace_builtin_hover false}
             :float_win_config {:border :none}}})

(setg conjure#filetypes [:clojure
                         :fennel
                         :hy
                         :janet
                         :julia
                         :lisp
                         ; :lua
                         :python
                         :racket
                         ; :rust
                         :scheme
                         :sql])

;; text
(se breakindent)
(se completeopt "menuone,noselect")
(se confirm)
(se expandtab)
(se linebreak)
(se nowrap)
(se shiftwidth 4)
(se softtabstop 4)
(se tabstop 4)
(se textwidth 80)

;; mouse
(se mouse :a)

;; statuscolumn
(se foldcolumn :0)
(se foldenable)
(se foldlevel 99)
(se foldlevelstart 99)
(se nonu)
(se nornu)
(se signcolumn :yes)

;; visual
(se background :dark)
(se cmdheight 1)
(se conceallevel 3)
(se fillchars "vert:▏,eob: ")
(se laststatus 2)
(se lazyredraw)
(se nocursorline)
(se cursorlineopt :both)
(se noruler)
(se noshowcmd)
(se noshowmode)
(se showtabline 0)
(se termguicolors)
; (se+ gcr "n:blinkwait1400-blinkoff400-blinkon250,i:block")
(se+ shm :Iq)

;; window
(se inccommand :split)
(se splitbelow)
(se splitkeep :topline)

;; keys
(se ignorecase)
(se nottimeout)
(se scrolloff 5)
; (se sidescrolloff 10)
(se smartcase)

;; file
(se noswapfile)
(se undofile)

;; system
(se autochdir)
(se clipboard :unnamedplus)

;; signs
(sign DiagnosticSignError {:text "■" :texthl :DiagnosticSignError})
(sign DiagnosticSignWarn {:text "■" :texthl :DiagnosticSignWarn})
(sign DiagnosticSignInfo {:text "■" :texthl :DiagnosticSignInfo})
(sign DiagnosticSignHint {:text "■" :texthl :DiagnosticSignHint})

