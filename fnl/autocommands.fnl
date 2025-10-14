(import-macros {: au} :macros)

;;; General

;; Highlight yank
(au :TextYankPost "*" #(vim.hl.on_yank {:higroup :Search :timeout 200}))

;; Open help in new tab
(au :Filetype :help #(vim.cmd "wincmd T"))

;; Autosave with filter
(let [ft_filter [:sql :gdscript :hyprlang]]
  (au [:TextChanged :InsertLeave] "*"
      #(when (and (= vim.bo.buftype "")
                  (not (vim.tbl_contains ft_filter vim.bo.filetype)))
         (if AutosaveTimer
             (AutosaveTimer:stop)
             (global AutosaveTimer (vim.uv.new_timer)))
         (AutosaveTimer:start 150 0
                              #(do
                                 (vim.schedule #(vim.cmd "silent! update"))
                                 (AutosaveTimer:stop)
                                 (AutosaveTimer:close)
                                 (global AutosaveTimer nil))))))

;;; Lsp

;; Disable lsp semantic tokens
(au :LspAttach "*" (fn [args]
                     (if (?. args :data :client_id)
                         (let [client (vim.lsp.get_client_by_id args.data.client_id)]
                           (when client
                             (set client.server_capabilities.semanticTokensProvider
                                  nil))))))

;; Change lsp winopts
(au :LspAttach "*"
    #(let [max_width (math.floor (* vim.o.columns 0.8))
           max_height (math.floor (- (/ vim.o.lines 2) 2))
           close_events [:CursorMoved]
           winopts {: max_width : max_height : close_events}]
       (nmap :<CR> vim.lsp.buf.code_action)
       (nmap :<C-w><C-d> #(vim.diagnostic.open_float winopts))
       (nmap :K #(vim.lsp.buf.hover winopts))))

;;; Special buffers

;; Add q quit keymap
(au [:BufReadPost] "*"
    #(when (not (vim.tbl_contains ["" :acwrite] vim.bo.buftype))
       (nmap :q :<C-w>q {:buffer true})))

;; Change background color
(let [gui_fn #(set vim.opt_local.winhl "Normal:MsgArea")]
  (au :FileType [:orgagenda :oil] gui_fn)
  (au [:BufReadPost] "*" #(when (or (not (vim.tbl_contains ["" :acwrite]
                                                           vim.bo.buftype)))
                            (gui_fn))))

;; Hide line numbers
(au :FileType [:org :orgagenda :fugitive]
    (fn []
      (set vim.opt_local.number false)
      (set vim.opt_local.conceallevel 3)
      (set vim.opt_local.relativenumber false)))
