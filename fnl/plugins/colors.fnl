(import-macros {: se : hl : au : setup : plug} :macros)

(plug :kvrohit/rasmus.nvim
      {:enabled false
       :lazy false
       :priority 1000
       :config (fn []
                 (vim.cmd "colorscheme rasmus"))})

(plug :felipeagc/fleet-theme-nvim
      {:enabled true
       :lazy false
       :priority 1000
       :config (fn []
                 (vim.cmd "colorscheme fleet")
                 (hl IlluminatedWordText {:guibg "#2E2E2E"})
                 (hl IlluminatedWordRead {:guibg "#2E2E2E"})
                 (hl IlluminatedWordWrite {:guibg "#2E2E2E"})
                 (hl DiagnosticError {:guibg :none})
                 (hl DiagnosticWarn {:guibg :none})
                 (hl DiagnosticInfo {:guibg :none})
                 (hl DiagnosticHint {:guibg :none}))})

;; fnlfmt: skip
(plug :catppuccin/nvim
      {:enabled false
       :lazy false
       :name :catppuccin
       :priority 1000
       :config (fn [_ opts]
                 (setup :catppuccin opts)
                 (vim.cmd.colorscheme :catppuccin))
       :opts {:flavour :mocha
              :custom_highlights (fn [colors]
                                   (set _G.colors colors)
                                   {:FzfLuaHeaderBind {:fg colors.lavender}
                                    :FzfLuaHeaderText {:fg colors.lavender}
                                    :TroubleCount {:fg colors.green}
                                    :CursorLine {:bg "#1E1E2E"}
                                    :CursorNr {:bg "#1E1E2E"}
                                    :CursorSign {:bg "#1E1E2E"}
                                    :TreesitterContext {:bg colors.mantle}
                                    :TroubleText {:bg colors.none}
                                    :TroubleFoldIcon {:bg colors.none}
                                    ; :CursorInsert {:bg colors.green}
                                    ; :Cursor {:bg colors.rosewater}
                                    ; :Cursor {:style [:reverse]}
                                    "@neorg.todo_items.pending" {:style [:altfont]}
                                    "@neorg.todo_items.on_hold" {:fg colors.blue
                                                                  :bg colors.none}})}})

(plug :norcalli/nvim-colorizer.lua)

(plug :bluz71/vim-moonfly-colors
      {:enabled false
       :priority 1000
       :config (fn [] (vim.cmd.colorscheme :moonfly))})

