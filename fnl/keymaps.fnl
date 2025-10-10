(set vim.g.mapleader " ")
(set vim.g.maplocalleader :m)

(local toggle
       (fn [...]
         (let [options [...]]
           (each [_ option (ipairs options)]
             (set (. vim.o option) (not (. vim.o option)))))))

;;; General

(nmap :<Esc> #(cmd "nohl | echo"))

(nmap :K #(vim.cmd.help (vim.fn.expand :<cword>)))

(imap :<C-n> :<Down>)
(imap :<C-p> :<Up>)

(nmap :<Leader>m :m)
(nmap :<Leader>i cmd.Inspect)

;; j/k movement when hard-wrapping
(map [:n :x] :k "v:count == 0 ? 'gk' : 'k'" {:expr true})
(map [:n :x] :j "v:count == 0 ? 'gj' : 'j'" {:expr true})

(nmap "<C-;>" :gccj {:remap true})
(xmap "<C-;>" :gc {:remap true})

;;; Files

;; Finders
(nmap :<Leader>f ":find ")
(nmap :g/ (.. ":grep  | copen" (vim.fn.repeat :<Left> 8)))
(map "!" :<C-Enter> "<Esc>:vimgrep // % | copen<CR>")

;; Yanking
(nmap :yr "ggVG\"+y<C-o>")
(nmap :yc :yygccp {:remap true})

;; Copy to system clipboard
(map [:n :x] :<Leader>p "\"+p")
(map [:n :x] :<Leader>y "\"+y")

;; (c)hange (o)ption
(nmap :cow #(toggle :wrap))
(nmap :con #(toggle :nu :rnu))
(nmap :cos #(if (not= vim.wo.scl :no)
                (set vim.wo.scl :no)
                (set vim.wo.scl :yes)))
