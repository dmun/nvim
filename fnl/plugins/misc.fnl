(import-macros {: plug : se} :macros)

(plug :Eandrju/cellular-automaton.nvim)

(plug :folke/which-key.nvim
      {:enabled false
       :event :VeryLazy
       :init (fn [] (se timeout)
               (se timeoutlen 300))
       :opts {:key_labels {:<space> :SPC :<cr> :RET :<tab> :TAB}}})

