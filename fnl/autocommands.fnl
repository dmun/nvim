(import-macros {: au} :macros)

(au :CmdlineEnter "*" #(set vim.o.ch 1))
(au :CmdlineLeave "*" #(set vim.o.ch 0))
(au :TextYankPost "*" #(vim.hl.on_yank {:higroup :Search :timeout 200}))

(au :LspAttach "*" (fn [args]
                     (if (?. args :data :client_id)
                         (let [client (vim.lsp.get_client_by_id args.data.client_id)]
                           (when client
                             (set client.server_capabilities.semanticTokensProvider
                                  nil))))))

(local filter [:sql])
(au [:TextChanged :InsertLeave] "*"
    #(when (and (= vim.bo.buftype "")
                (not (vim.tbl_contains filter vim.bo.filetype)))
       (if AutosaveTimer
           (AutosaveTimer:stop)
           (global AutosaveTimer (vim.uv.new_timer)))
       (AutosaveTimer:start 250 0
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

