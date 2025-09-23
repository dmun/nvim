(import-macros {: au} :macros)

; (au :CmdlineEnter "*" #(set vim.o.ch 1))
; (au :CmdlineLeave "*" #(set vim.o.ch 0))
(au :TextYankPost "*" #(vim.hl.on_yank {:higroup :Search :timeout 200}))

(au :Filetype :help #(vim.cmd "wincmd T"))

(au :LspAttach "*" (fn [args]
                     (if (?. args :data :client_id)
                         (let [client (vim.lsp.get_client_by_id args.data.client_id)]
                           (when client
                             (set client.server_capabilities.semanticTokensProvider
                                  nil))))))

(local filter [:sql :gdscript :hyprlang])
(au [:TextChanged :InsertLeave] "*"
    #(when (and (= vim.bo.buftype "")
                (not (vim.tbl_contains filter vim.bo.filetype)))
       (if AutosaveTimer
           (AutosaveTimer:stop)
           (global AutosaveTimer (vim.uv.new_timer)))
       (AutosaveTimer:start 150 0
                            #(do
                               (vim.schedule #(vim.cmd "silent! update"))
                               (AutosaveTimer:stop)
                               (AutosaveTimer:close)
                               (global AutosaveTimer nil)))))

(au :LspAttach "*"
    #(let [max_width (math.floor (* vim.o.columns 0.8))
           max_height (math.floor (- (/ vim.o.lines 2) 2))
           close_events [:CursorMoved]
           winopts {: max_width : max_height : close_events}]
       (nmap :<CR> vim.lsp.buf.code_action)
       (nmap :<C-w><C-d> #(vim.diagnostic.open_float winopts))
       (nmap :K #(vim.lsp.buf.hover winopts))))

(au :BufWritePost :gtk.css
    #(let [theme (vim.fn.fnamemodify (vim.fn.getcwd) ":t")
           basecmd "gsettings set org.gnome.desktop.interface gtk-theme "]
       (vim.fn.system (.. basecmd "''"))
       (vim.fn.system (.. basecmd "'" theme "'"))
       (vim.notify (.. "reloaded gtk-theme: " theme))))

(au [:BufReadPost] "*"
    #(when (not (vim.tbl_contains ["" :acwrite] vim.bo.buftype))
       (nmap :q :<C-w>q {:buffer true})))

(let [gui_fn #(set vim.opt_local.winhl "Normal:MsgArea")]
    (au [:BufReadPost] "*"
        #(when (or (not (vim.tbl_contains [""] vim.bo.buftype)))
           (gui_fn)))
    (au :FileType [:orgagenda] gui_fn))

(au :FileType [:org :orgagenda :fugitive]
    (fn []
      (set vim.opt_local.number false)
      (set vim.opt_local.conceallevel 3)
      (set vim.opt_local.relativenumber false)))
