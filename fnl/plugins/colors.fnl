(import-macros {: se : hl : au : setup : plug} :macros)

(plug :kvrohit/rasmus.nvim
      {:enabled false
       :lazy false
       :priority 1000
       :config (fn []
                 (vim.cmd.colorscheme :rasmus))})

(plug :felipeagc/fleet-theme-nvim
      {:enabled true
       :dependencies [:nvim-lualine/lualine.nvim]
       :lazy false
       :priority 1000
       :config (fn []
                 (vim.cmd.colorscheme :fleet)
                 (hl lualine_a_normal {:fg "#2197F3" :bg "#1F3661"})
                 (hl TroubleCount {:fg "#2197F3" :bg "#1F3661"})
                 (hl IlluminatedWordText {:bg "#2E2E2E"})
                 (hl IlluminatedWordRead {:bg "#2E2E2E"})
                 (hl IlluminatedWordWrite {:bg "#2E2E2E"})
                 (hl DiagnosticError {:bg :none})
                 (hl DiagnosticWarn {:bg :none})
                 (hl DiagnosticInfo {:bg :none})
                 (hl DiagnosticHint {:bg :none})
                 (hl CursorLine {:bg "#292929"})
                 (hl CursorLineNr {:bg "#292929"})
                 (hl CursorLineSign {:bg "#292929"})
                 (hl CursorLineFold {:bg "#292929"}))})

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

