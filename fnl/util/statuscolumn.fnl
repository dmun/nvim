#(let [wo (. vim.wo vim.g.statusline_winid)
       text (.. (if (not= wo.signcolumn :no) "%s" "") "%=")]
   (if (or (not wo.nu) (> vim.v.virtnum 0) (< vim.v.virtnum 0))
       ""
       (.. (if (= vim.v.relnum 0) (.. "%#CursorLineNr#" text vim.v.lnum)
               wo.rnu (.. text vim.v.relnum)
               (.. text vim.v.lnum)) " ")))
