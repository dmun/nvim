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

(plug :felipeagc/fleet-theme-nvim
      {:enabled true
       :dependencies [:nvim-lualine/lualine.nvim]
       :lazy false
       :priority 1000
       :config (fn []
                 (vim.cmd.colorscheme :fleet)
                 ;; lsp
                 (hl DiagnosticError {:bg :none})
                 (hl DiagnosticWarn {:bg :none})
                 (hl DiagnosticInfo {:bg :none})
                 (hl DiagnosticHint {:bg :none})
                 (hl "@lsp.type.selfKeyword.rust" {:fg "#CC7C89"})
                 (hl "@lsp.type.interface.rust" "@type")
                 ;; plugins
                 (hl Sneak {:fg "#1A1A1A" :bg "#D898D8" :gui :bold})
                 (hl SneakLabel {:fg "#1A1A1A" :bg "#D898D8" :gui :bold})
                 (hl lualine_a_insert {:fg "#1A1A1A" :bg "#78D0BD"})
                 (hl lualine_a_normal {:fg "#FFFFFF" :bg "#535353"}) (hl TroubleCount {:fg "#2197F3" :bg "#1F3661"})
                 (hl IlluminatedWordText {:bg "#2E2E2E"})
                 (hl IlluminatedWordRead {:bg "#2E2E2E"})
                 (hl IlluminatedWordWrite {:bg "#2E2E2E"})
                 (hl LeapMatch CurSearch))})

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

