(import-macros {: nmap} :macros)

;; auto-save
(nmap <leader>as :<CMD>ASToggle<CR>)

;; colorizer
(nmap <leader>tc :<CMD>ColorizerToggle<CR>)

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
(nmap <leader>1 "<CMD>lua require('harpoon.ui').nav_file(1)<CR>")
(nmap <leader>2 "<CMD>lua require('harpoon.ui').nav_file(2)<CR>")
(nmap <leader>3 "<CMD>lua require('harpoon.ui').nav_file(3)<CR>")
(nmap <leader>4 "<CMD>lua require('harpoon.ui').nav_file(4)<CR>")

;; sneak
(nmap f :<Plug>Sneak_f)
(nmap F :<Plug>Sneak_F)
(nmap t :<Plug>Sneak_t)
(nmap T :<Plug>Sneak_T)

