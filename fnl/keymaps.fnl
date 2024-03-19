(import-macros {: nmap : imap : vmap} :macros)

;; general
(nmap <ESC> "<cmd>echo<bar>nohl<bar>silent update<cr>")
(nmap <leader>mr "<cmd>!make -s run<cr>")
(nmap u "<cmd>silent undo<cr>")
(nmap <C-r> "<cmd>silent redo<cr>")
(vmap <localleader>s ":'<,'>!sort<cr>")

(imap <C-n> "<cmd>norm j<cr>")
(imap <C-p> "<cmd>norm k<cr>")
(imap <C-k> "<cmd>norm dd<cr>")

(nmap <C-h> :<C-w>h)
(nmap <C-j> :<C-w>j)
(nmap <C-k> :<C-w>k)
(nmap <C-l> :<C-w>l)

;; toggles
(nmap <leader>tc :<cmd>ColorizerToggle<cr>)
(nmap <leader>ts :<cmd>ASToggle<cr>)
(nmap <leader>tw "<cmd>set wrap!<cr>")
(nmap <leader>tl "<cmd>Lazy<cr>")
(nmap <leader>tm "<cmd>Mason<cr>")

;; fzf-lua
(nmap <leader><leader> "<cmd>FzfLua files<cr>")
(nmap <leader>fr "<cmd>FzfLua oldfiles<cr>")
(nmap <leader>/ "<cmd>FzfLua live_grep_native<cr>")
(nmap <leader>? "<cmd>FzfLua live_grep_resume<cr>")
(nmap <leader><comma> "<cmd>FzfLua buffers<cr>")
(nmap <leader>bi "<cmd>FzfLua builtin<cr>")
(nmap <M-x> "<cmd>FzfLua commands<cr>")
(nmap <leader>a "<cmd>FzfLua lsp_code_actions<cr>")

; ;; telescope
; (nmap <leader><leader> "<cmd>Telescope find_files<cr>")
; (nmap <leader>fr "<cmd>Telescope oldfiles<cr>")
; (nmap <leader>/ "<cmd>Telescope live_grep<cr>")
; (nmap <leader><comma> "<cmd>Telescope buffers<cr>")
; (nmap <leader>fh "<cmd>Telescope help_tags<cr>")

;; oil
(nmap <leader>e :<cmd>Oil<cr>)

;; lazy
(nmap <leader>la :<cmd>Lazy<cr>)

;; mason
(nmap <leader>ls :<cmd>Mason<cr>)

;; harpoon
(nmap <leader>m "<cmd>lua require('harpoon.mark').add_file()<cr>")
(nmap <leader>q "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
(nmap <leader>1 "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
(nmap <leader>2 "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
(nmap <leader>3 "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
(nmap <leader>4 "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
(nmap <leader>5 "<cmd>lua require('harpoon.ui').nav_file(5)<cr>")

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
(nmap <leader>k vim.diagnostic.open_float)
(nmap <space>rn vim.lsp.buf.rename)
(nmap <leader>wa vim.lsp.buf.add_workspace_folder)
(nmap <leader>wr vim.lsp.buf.remove_workspace_folder)
(nmap <leader>wl "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>")

;; conform
(nmap <leader>bf (partial (#$.format (require :conform) {:async true})))

;; trouble
(nmap <leader>d :<cmd>TroubleToggle<cr>)
(nmap <leader>D "<cmd>TroubleToggle lsp_definitions<cr>")
(nmap gr "<cmd>TroubleToggle lsp_references<cr>")

