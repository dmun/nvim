(add :Olical/conjure)
(nmap :<LocalLeader>e vim.cmd.ConjureEval)

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
