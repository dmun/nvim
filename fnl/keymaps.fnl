(import-macros {: nmap : vmap} :macros)

;; general
(nmap <ESC> :<CMD>echo<bar>nohl<CR>)
(nmap <localleader>r "<CMD>!make -s run<CR>")
(vmap <localleader>s ":'<,'>!sort<CR>")

(vmap J ":m '>+1<CR>gv=gv")
(vmap K ":m '<-2<CR>gv=gv")

; (nmap j "v:count ? (v:count > 5 ? 'm\'' . v:count : '') . 'j' : 'gj'")
; (nmap k "v:count ? (v:count > 5 ? 'm\'' . v:count : '') . 'k' : 'gk'")
; (nmap 0 &wrap ? 'g0' : '0')
; (nmap $ &wrap ? 'g$' : '$')

;; toggles
(nmap <leader>tc :<CMD>ColorizerToggle<CR>)
(nmap <leader>ts :<CMD>ASToggle<CR>)
(nmap <leader>tw "<CMD>set wrap!<CR>")

;; fzf-lua
(nmap <leader><leader> "<CMD>FzfLua files<CR>")
(nmap <leader>fr "<CMD>FzfLua oldfiles<CR>")
(nmap <leader>/ "<CMD>FzfLua live_grep_native<CR>")
(nmap <leader>? "<CMD>FzfLua live_grep_resume<CR>")
(nmap <leader><comma> "<CMD>FzfLua buffers<CR>")
(nmap <leader>bi "<CMD>FzfLua builtin<CR>")
(nmap <M-x> "<CMD>FzfLua commands<CR>")
(nmap <leader>ca "<CMD>FzfLua lsp_code_actions<CR>")

;; oil
(nmap <leader>e :<CMD>Oil<CR>)

;; harpoon
(nmap <leader>m "<CMD>lua require('harpoon.mark').add_file()<CR>")
(nmap <leader>q "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>")

(for [n 1 5]
  (->> n (nmap <leader><?> "<CMD>lua require('harpoon.ui').nav_file(<?>)<CR>")))

;; sneak
(nmap f :<Plug>Sneak_f)
(nmap F :<Plug>Sneak_F)
(nmap t :<Plug>Sneak_t)
(nmap T :<Plug>Sneak_T)

