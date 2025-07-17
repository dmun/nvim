(import-macros {: au} :macros)

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

