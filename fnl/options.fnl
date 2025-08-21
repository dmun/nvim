(local o vim.o)

(add {:source :dmun/boomer.nvim :depends [:rktjmp/lush.nvim]})
(vim.cmd.color :boomer)

(set vim.g.conjure#mapping#doc_word :gk)
(set vim.g.conjure#filetypes [:clojure
                              :fennel
                              :janet
                              :hy
                              :julia
                              :racket
                              :scheme
                              ; :lua
                              :lisp
                              :python
                              ; :rust
                              :sql])

(fn _G.Fd [pattern]
  (vim.fn.systemlist (.. "fd --color=never --full-path --type file --hidden "
                         "--exclude='.git' --exclude='deps' '" pattern "'")))

(set vim.o.ffu "v:lua.Fd")
(set o.sd (.. o.sd ",f1000"))
(set o.ttimeoutlen 0)
(set o.lcs "tab:  ")
(set o.list true)
(set o.nu true)
(set o.rnu true)
(set o.so 0)
(set o.gcr "")
(set o.cul true)
(set o.culopt :number)
(set o.sms true)
(set o.shm :IcFsCW)
(set o.winborder :single)
(set o.cot :menuone)
(set o.scl :no)
(set o.swf false)
(set o.ignorecase true)
(set o.scs true)
(set o.undofile true)
(set o.et true)
(set o.ts 4)
(set o.sw 4)
(set o.siso 4)
(set o.si true)
(set o.smd false)
(set o.ru false)
(set o.sc false)
(set o.ph 6)
(set o.wrap false)
(set o.spk :screen)
(set o.fcs "eob: ")
(set o.acd true)
(set o.bri true)
(set o.ch 1)
(set o.stc "%!v:lua.require'util.statuscolumn'.init()")

(vim.diagnostic.config {:signs false})
(set vim.highlight.priorities.semantic_tokens 95)

