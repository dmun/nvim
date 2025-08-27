(set vim.g.mapleader " ")
(set vim.g.maplocalleader "m")

(local toggle
       (fn [...]
         (let [options [...]]
           (each [_ option (ipairs options)]
             (set (. vim.o option) (not (. vim.o option)))))))

(nmap "g/" (.. ":grep  | copen" (vim.fn.repeat :<Left> 8)))

(nmap "<C-;>" :gccj {:remap true})
(xmap "<C-;>" :gc {:remap true})

(nmap :K #(vim.cmd.help (vim.fn.expand :<cword>)))
; (imap :jk :<Esc>)
; (imap :kj :<Esc>)

(nmap :yr "ggVG\"+y<C-o>")
(nmap :yc :yygccp {:remap true})
(map "!" :<C-Enter> "<Esc>:vimgrep // % | copen<CR>")

(nmap :<Leader>m :m)
(nmap :d<Tab> (. (require :util) :pcommands))

(nmap :<Leader>i cmd.Inspect)
(imap :<C-x>i cmd.Inspect)

(require :util.jump)
(nmap :s #(Patrick.jump 2 false))
(nmap :S #(Patrick.jump 2 true))
(xmap :s #(Patrick.jump 2 false))
(xmap :S #(Patrick.jump 2 true))
(omap :s (Patrick.jump_op 2 false true))
(omap :S (Patrick.jump_op 2 true true))

;; (nmap :f #(Patrick.jump 1 false))
;; (nmap :F #(Patrick.jump 1 true))
;; (xmap :f #(Patrick.jump 1 false))
;; (xmap :F #(Patrick.jump 1 true))
;; (omap :f (Patrick.jump_op 1 false))
;; (omap :F (Patrick.jump_op 1 true))
;;
;; (nmap :t #(Patrick.jump 1 false true))
;; (nmap :T #(Patrick.jump 1 true true))
;; (xmap :t #(Patrick.jump 1 false true))
;; (xmap :T #(Patrick.jump 1 true true))
;; (omap :t (Patrick.jump_op 1 false true))
;; (omap :T (Patrick.jump_op 1 true true))

(nmap :<C-t> cmd.copen)
(nmap :<M-n> cmd.cnext)
(nmap :<M-p> cmd.cprev)

(nmap :<M-o> "<Cmd>!open .<CR>")

;; (nmap :<C-d> "<C-d>zz")
;; (nmap :<C-u> "<C-u>zz")

(nmap :n :nzz)
(nmap :N :Nzz)

(map [:n :x] :k "v:count == 0 ? 'gk' : 'k'" {:expr true})
(map [:n :x] :j "v:count == 0 ? 'gj' : 'j'" {:expr true})

(map [:n :x] :<Leader>p "\"+p")
(map [:n :x] :<Leader>y "\"+y")

(nmap :gr<Space> ":grep ")

(nmap :cow #(toggle :wrap))
(nmap :con #(toggle :nu :rnu))
(nmap :cos (fn []
             (if (not= vim.wo.scl :no)
                 (set vim.wo.scl :no)
                 (set vim.wo.scl :yes))))

(nmap :<Esc> #(cmd "nohl | echo"))

(nmap :<C-h> :<C-w>h)
(nmap :<C-j> :<C-w>j)
(nmap :<C-k> :<C-w>k)
(nmap :<C-l> :<C-w>l)

(nmap :<Leader>f ":find ")

