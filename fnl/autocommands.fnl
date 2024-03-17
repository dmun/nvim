(import-macros {: au : aug : se} :macros)

;; hide statusline for popup style windows
; (vim.cmd "autocmd! FileType fzf,NeogitPopup,Trouble")
; (au :FileType
;     {:pattern [:fzf :NeogitPopup :Trouble]
;      :callback (fn []
;                  (se laststatus 0)
;                  (au :BufLeave
;                      {:pattern :<buffer> :callback (fn [] (se laststatus 2))}))})

;; highlight on yank
(let [hi-group (aug :YankHighlight {:clear true})]
  (au :TextYankPost {:callback (fn [] (vim.highlight.on_yank)
                                 :group
                                 hi-group
                                 :pattern
                                 "*")}))

;; auto-save
(au [:BufLeave :FocusLost]
    {:callback (fn []
                 (if (= vim.bo.buftype "")
                     (vim.cmd "silent update")))})

