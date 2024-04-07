(import-macros {: nmap : imap : vmap : nremap : setg} :macros)

;; leader keys
(setg mapleader " ")
(setg maplocalleader " m")

;; general
(nmap <ESC> "<cmd>echo<bar>nohl<bar>silent update<cr>")
(nmap <leader>r "<cmd>!make -s run<cr>")
(vmap <localleader>s ":'<,'>!sort<cr>")
(nmap <leader>i :<cmd>Inspect<cr>)
(nremap u "<cmd>silent undo<cr>")
(nremap <C-r> "<cmd>silent redo<cr>")

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
(nmap <leader>tl :<cmd>Lazy<cr>)
(nmap <leader>tm :<cmd>Mason<cr>)
(nmap <leader>tg "<cmd>Gitsigns toggle_signs<cr>")
(nmap <leader>tn "<cmd>se nu!<cr>")

;; fzf-lua
(nmap <leader>f "<cmd>FzfLua files<cr>")
(nmap <leader>of "<cmd>FzfLua oldfiles<cr>")
(nmap <leader>/ "<cmd>FzfLua live_grep_native<cr>")
(nmap <leader>? "<cmd>FzfLua live_grep_resume<cr>")
(nmap <leader><comma> "<cmd>FzfLua buffers<cr>")
(nmap <leader><leader> "<cmd>FzfLua builtin<cr>")
(nmap <leader>hf "<cmd>FzfLua highlights<cr>")
(nmap <M-x> "<cmd>FzfLua commands<cr>")

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

;; refactor
(vmap <leader>v "<cmd>Refactor extract_var<cr>")
(vmap <leader>f "<cmd>Refactor extract_function<cr>")

;; sneak
(nmap f :<Plug>Sneak_f)
(nmap F :<Plug>Sneak_F)
(nmap t :<Plug>Sneak_t)
(nmap T :<Plug>Sneak_T)

;; lsp
(nmap <M-CR> ":Lspsaga code_action<CR>")
(nmap K (fn []
          (vim.cmd.call "sneak#cancel()")
          (vim.lsp.buf.hover)))

(nmap gD vim.lsp.buf.declaration)
(nmap gd "<cmd>Glance definitions<cr>")
(nmap gi "<cmd>Glance implementations<cr>")
(nmap gr "<cmd>Glance references<cr>")
(nmap "]d" vim.diagnostic.goto_next)
(nmap "[d" vim.diagnostic.goto_prev)
(nmap <leader>k vim.diagnostic.open_float)
(nmap <leader>rn vim.lsp.buf.rename)
(nmap <leader>wa vim.lsp.buf.add_workspace_folder)
(nmap <leader>wr vim.lsp.buf.remove_workspace_folder)
(nmap <leader>wl "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>")

;; conform
(nmap <leader>bf (partial (#$.format (require :conform) {:async true})))

;; trouble
(nmap <leader>d :<cmd>TroubleToggle<cr>)
(nmap <leader>D "<cmd>TroubleToggle lsp_definitions<cr>")

