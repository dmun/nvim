(import-macros {: plug : nmap : xmap} :macros)

(plug :lewis6991/gitsigns.nvim
      {:event [:BufReadPre :BufNewFile]
       :opts {:attach_to_untracked false
              :signs {:add {:text "▎"}
                      :change {:text "▎"}
                      :delete {:text "▁"}
                      :topdelete {:text "▔"}
                      :changedelete {:text "▎"}}
              :on_attach (fn [bufnr]
                           (let [gs package.loaded.gitsigns]
                             ;; Navigation
                             (xmap :n "]c"
                                   (fn []
                                     (if vim.wo.diff
                                         "]c"
                                         (do
                                           (vim.schedule (fn [] (gs.next_hunk)))
                                           :<Ignore>))))
                             (xmap :n "[c"
                                   (fn []
                                     (if vim.wo.diff
                                         "[c"
                                         (do
                                           (vim.schedule (fn [] (gs.prev_hunk)))
                                           :<Ignore>))))
                             ;; Actions
                             (nmap <leader>hs ":Gitsigns stage_hunk<CR>")
                             (nmap <leader>hr ":Gitsigns reset_hunk<CR>")
                             (nmap <leader>hS gs.stage_buffer)
                             (nmap <leader>hu gs.undo_stage_hunk)
                             (nmap <leader>hR gs.reset_buffer)
                             (nmap <leader>hp gs.preview_hunk)
                             (nmap <leader>hb
                                   (fn []
                                     (gs.blame_line {:full true})))
                             (nmap <leader>tb gs.toggle_current_line_blame)
                             (nmap <leader>hd gs.diffthis)
                             (nmap <leader>hD
                                   (fn []
                                     (gs.diffthis "~")))
                             (nmap <leader>td gs.toggle_deleted)))}})
                             ;; Text object
                             ; (nmap ih ":<C-U>Gitsigns select_hunk<CR>")))}})

