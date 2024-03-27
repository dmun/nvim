(import-macros {: se : setg : hl : au : setup : plug} :macros)

(plug :rktjmp/lush.nvim)
(plug :metalelf0/jellybeans-nvim
      {:enabled false
       :config (fn []
                 (vim.cmd.color :jellybeans-nvim)
                 (hl "@lsp.type.variable" Normal)
                 (hl "@lsp.type.keyword" Identifier)
                 (hl IlluminatedWordRead {:bg "#242424"})
                 (hl IlluminatedWordWrite {:bg "#242424"})
                 (hl IlluminatedWordText {:bg "#242424"})
                 (hl DiagnosticUnderlineError {:gui :undercurl})
                 (hl DiagnosticUnderlineHint {:gui :undercurl})
                 (hl DiagnosticUnderlineInfo {:gui :undercurl})
                 (hl DiagnosticUnderlineOk {:gui :undercurl})
                 (hl DiagnosticUnderlineWarn {:gui :undercurl}))})

(plug :sainnhe/gruvbox-material
      {:enabled false
       :config (fn []
                 (setg gruvbox_material_foreground :material)
                 (setg gruvbox_material_background :hard)
                 (vim.cmd.color :gruvbox-material))})

(plug :norcalli/nvim-colorizer.lua)

(plug :dmun/fleet-theme-nvim
      {; :dir "$HOME/Development/fleet-theme-nvim"
       :enabled true
       :lazy false
       :priority 1000
       :config (fn [] (vim.cmd.colorscheme :fleet))})

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
                                    "@neorg.todo_items.pending" {:style [:altfont]}
                                    "@neorg.todo_items.on_hold" {:fg colors.blue
                                                                  :bg colors.none}})}})

