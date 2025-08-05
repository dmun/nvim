(local o vim.o)

(fn hsluv->rgb [h s l]
  (let [h (/ h 360)
        s (/ s 100)
        l (/ l 99)
        maxLightness 0.9999999
        minLightness 1e-07
        h (% h 1)
        s (math.min (math.max s 0) 1)
        l (math.min (math.max l 0) 1)]
    (let [c (* (- 1 (math.abs (- (* 2 l) 1))) s)
          x (* c (- 1 (math.abs (- (* 3 h) 1))))
          m (- l (/ c 2))
          r (if (< h (/ 1 3)) c x)
          g (if (< h (/ 2 3)) c (if (< h (/ 1 3)) x 0))
          b (if (< h (/ 2 3)) x c)]
      [(+ r m) (+ g m) (+ b m)])))

(fn hsluv [h s l]
  (let [rgb (hsluv->rgb h s l)
        hex (string.format "#%02x%02x%02x" (math.floor (* 255 (. rgb 1)))
                           (math.floor (* 255 (. rgb 2)))
                           (math.floor (* 255 (. rgb 3))))]
    hex))

(add {:source :dmun/boomer.nvim :depends [:rktjmp/lush.nvim]})
(vim.cmd.color :boomer)
(vim.cmd.hi (.. "@table.key guifg=" (hsluv 250 20 85)))

(set vim.g.conjure#mapping#doc_word :gk)
(set vim.g.conjure#filetypes [:clojure
                              ; :fennel
                              :janet
                              :hy
                              :julia
                              :racket
                              :scheme
                              :lua
                              :lisp
                              :python
                              :rust
                              :sql])

(fn _G.Fd [pattern]
  (vim.fn.systemlist (.. "fd --color=never --full-path --type file --hidden "
                         "--exclude='.git' --exclude='deps' '" pattern "'")))

(set vim.o.ffu "v:lua.Fd")
(set o.sd (.. o.sd ",f1000"))
(set o.ttimeoutlen 0)
(set o.lcs "tab:  ")
(set o.list true)
(set o.nu false)
(set o.rnu false)
(set o.so 0)
(set o.gcr "")
(set o.cul true)
(set o.culopt :number)
(set o.sms true)
(set o.shm :IcFsCW)
(set o.winborder :solid)
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

