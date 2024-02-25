(import-macros {: se : se+ : setg} :macros)

(vim.cmd.source :$HOME/.config/nvim/.vimrc)

;; leader keys
(setg mapleader " ")
(setg maplocalleader ",")

;; global options
(setg rooter_silent_chdir 1)
(setg sneak#use_ic_scs 1)
(setg sneak#s_next 1)
(setg tex_flavor :latex)
(setg conjure#filetypes [:clojure
                         :fennel
                         :hy
                         :janet
                         :julia
                         :lisp
                         ; :lua
                         :python
                         :racket
                         :rust
                         :scheme
                         :sql])

;; text
(se breakindent)
(se completeopt "menuone,noselect")
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
; (se number)
; (se relativenumber)

;; visual
(se background :dark)
(se conceallevel 3)
(se fillchars "vert:▏,eob: ")
(se gcr "n-v-c-sm:block-Cursor,i-ci:block-CursorInsert")
(se lazyredraw)
(se nocursorline)
(se noruler)
(se noshowcmd)
(se noshowmode)
(se showtabline 0)
(se termguicolors)
(se+ shm :Iq)

;; window
(se inccommand :split)
(se splitbelow)
(se splitkeep :topline)

;; keys
(se ignorecase)
(se nottimeout)
(se scrolloff 5)
(se sidescrolloff 10)
(se smartcase)

;; file
(se noswapfile)
(se undofile)

;; system
(se autochdir)
(se clipboard :unnamedplus)

