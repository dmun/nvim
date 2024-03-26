(import-macros {: plug} :macros)

(plug :nvim-neorg/neorg
      {:ft :norg
       :version :v7.0.0
       :dependencies [:nvim-lua/plenary.nvim :luarocks.nvim]
       :opts {:load {:core.defaults {}
                     :core.concealer {:config {:folds false
                                               :icon_preset :basic}}
                     :core.keybinds {:config {:hook (fn [keybinds]
                                                      (keybinds.remap_event :norg
                                                                            :n
                                                                            :<C-space>
                                                                            :core.qol.todo_items.todo.task_cycle_reverse))}}
                     :core.autocommands {}
                     :core.integrations.treesitter {}
                     :core.esupports.indent {}
                     :core.esupports.metagen {}
                     :core.completion {:config {:engine :nvim-cmp}}}}
       :build ":Neorg sync-parsers"})

