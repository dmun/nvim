(import-macros {: nmap : vmap} :macros)

;; general
(nmap <ESC> :<CMD>echo<bar>nohl<CR>)
(nmap <localleader>r "<CMD>!make -s run<CR>")
(vmap <localleader>s ":'<,'>!sort<CR>")

(vmap J ":m '>+1<CR>gv=gv")
(vmap K ":m '<-2<CR>gv=gv")

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
(nmap <localleader>m "<CMD>lua require('harpoon.mark').add_file()<CR>")
(nmap <leader>q "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>")

(for [n 1 5]
  (->> n (nmap <leader><?> "<CMD>lua require('harpoon.ui').nav_file(<?>)<CR>")))

;; sneak
(nmap f :<Plug>Sneak_f)
(nmap F :<Plug>Sneak_F)
(nmap t :<Plug>Sneak_t)
(nmap T :<Plug>Sneak_T)

;; lsp
(nmap K "<cmd>lua vim.lsp.buf.hover()<CR>")
(nmap "[d" "<cmd>lua vim.diagnostic.goto_prev()<CR>")
(nmap "]d" "<cmd>lua vim.diagnostic.goto_next()<CR>")
(nmap gD "<cmd>lua vim.lsp.buf.declaration()<CR>")
(nmap gd "<cmd>lua vim.lsp.buf.definition()<CR>")
(nmap gi "<cmd>lua vim.lsp.buf.implementation()<CR>")

(nmap <leader>bf "<cmd>lua require('conform').format({ async = true })<CR>")
(nmap <space>rn "<cmd>lua vim.lsp.buf.rename()<CR>")
(nmap <space>wa "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
(nmap <space>wl "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
(nmap <space>wr "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")

