; (add {:source :dmun/llemper.nvim
;       :depends [:nvim-lua/plenary.nvim]})
; (setup :llemper)

(add :zbirenbaum/copilot.lua)
(let [copilot (require :copilot)]
  (copilot.setup {:filetypes {:org false :terraform false}
                  :suggestion {:auto_trigger true :keymap {:accept :<Tab>}}}))
