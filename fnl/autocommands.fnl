(import-macros {: au : se} :macros)

(vim.cmd "autocmd! FileType fzf,NeogitPopup,Trouble")

(au :FileType
    {:pattern [:fzf :NeogitPopup :Trouble]
     :callback (fn []
                 (se laststatus 0
                     (au :BufLeave
                         {:pattern 0 :callback (fn [] (se laststatus 2))})))})

