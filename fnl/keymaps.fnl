(import-macros {: nmap : imap : vmap} :macros)

;; general
(nmap <ESC> "<CMD>echo<bar>nohl<bar>silent update<CR>")
(nmap <localleader>r "<CMD>!make -s run<CR>")
(vmap <localleader>s ":'<,'>!sort<CR>")

(imap <C-n> "<CMD>norm j<CR>")
(imap <C-p> "<CMD>norm k<CR>")
(imap <C-k> "<CMD>norm dd<CR>")

(nmap <C-h> :<C-w>h)
(nmap <C-j> :<C-w>j)
(nmap <C-k> :<C-w>k)
(nmap <C-l> :<C-w>l)

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

;; lazy
(nmap <leader>l :<CMD>Lazy<CR>)

;; harpoon
(nmap <leader>m "<CMD>lua require('harpoon.mark').add_file()<CR>")
(nmap <leader>q "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>")

(for [n 1 5]
  (->> n (nmap <leader><?> "<CMD>lua require('harpoon.ui').nav_file(<?>)<CR>")))

;; sneak
; (nmap f :<Plug>Sneak_f)
; (nmap F :<Plug>Sneak_F)
; (nmap t :<Plug>Sneak_t)
; (nmap T :<Plug>Sneak_T)

;; lsp
(nmap K vim.lsp.buf.hover)
(nmap gD vim.lsp.buf.declaration)
(nmap gd vim.lsp.buf.definition)
(nmap gi vim.lsp.buf.implementation)
(nmap "[d" vim.diagnostic.goto_prev)
(nmap "]d" vim.diagnostic.goto_next)
(nmap <space>rn vim.lsp.buf.rename)
(nmap <leader>wa vim.lsp.buf.add_workspace_folder)
(nmap <leader>wr vim.lsp.buf.remove_workspace_folder)
(nmap <leader>wl "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")

;; conform
(nmap <leader>bf (partial (#$.format (require :conform) {:async true})))

;; trouble
(nmap <leader>d "<CMD>TroubleToggle<CR>")
(nmap <leader>D "<CMD>TroubleToggle lsp_definitions<CR>")
(nmap gr "<CMD>TroubleToggle lsp_references<CR>")

