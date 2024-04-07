(import-macros {: se : setg : hl : au : setup : plug} :macros)

(plug :norcalli/nvim-colorizer.lua)

(plug :ellisonleao/gruvbox.nvim
      {:opts {:contrast :hard}
       :config (fn [_ opts]
                 (setup :gruvbox opts)
                 (vim.cmd.color :gruvbox)
                 (hl GitSignsAdd {:fg "#98971a" :bg "#3C3836"})
                 (hl GitSignsChange {:fg "#458588" :bg "#3C3836"})
                 (hl GitSignsDelete {:fg "#cc241d" :bg "#3C3836"}))})

