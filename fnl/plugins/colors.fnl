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
      {:enabled true
       :config (fn []
                 (setg gruvbox_material_foreground :original)
                 (setg gruvbox_material_background :hard)
                 (vim.cmd.color :gruvbox-material)
                 (hl PmenuSel {:fg :none :bg "#5D524A" :gui :bold})
                 (hl NormalFloat {:bg "#282828"})
                 (hl SagaNormal Pmenu)
                 (hl CodeActionCursorLine PmenuSel)
                 (hl ActionPreviewNormal NormalFloat))})

(plug :norcalli/nvim-colorizer.lua)

(plug :dmun/fleet-theme-nvim
      {; :dir "$HOME/Development/fleet-theme-nvim"
       :enabled false
       :lazy false
       :priority 1000
       :config (fn [] (vim.cmd.colorscheme :fleet))})

;; by s1m0000n
(local retro-dark {:rosewater "#ffc9c9"
                   :flamingo "#ff9f9a"
                   :pink "#ffa9c9"
                   :mauve "#df95cf"
                   :lavender "#a990c9"
                   :red "#ff6960"
                   :maroon "#f98080"
                   :peach "#f9905f"
                   :yellow "#f9bd69"
                   :green "#b0d080"
                   :teal "#a0dfa0"
                   :sky "#a0d0c0"
                   :sapphire "#95b9d0"
                   :blue "#89a0e0"
                   :text "#e0d0b0"
                   :subtext1 "#d5c4a1"
                   :subtext0 "#bdae93"
                   :overlay2 "#928374"
                   :overlay1 "#7c6f64"
                   :overlay0 "#665c54"
                   :surface2 "#504844"
                   :surface1 "#3a3634"
                   :surface0 "#252525"
                   :base "#151515"
                   :mantle "#0e0e0e"
                   :crust "#080808"})

(fn custom-highlights [colors]
  {:DiagnosticUnderlineOk {:style [:undercurl]}
   :DiagnosticUnderlineHint {:style [:undercurl]}
   :DiagnosticUnderlineInfo {:style [:undercurl]}
   :DiagnosticUnderlineError {:style [:undercurl]}
   :DiagnosticUnderlineWarn {:style [:undercurl]}
   :Sneak {:fg colors.base :bg colors.mauve}})

;; fnlfmt: skip
(plug :catppuccin/nvim
      {:enabled false
       :lazy false
       :name :catppuccin
       :priority 1000
       :config (fn [_ opts]
                 (setup :catppuccin opts)
                 (vim.cmd.color :catppuccin))
       :opts {:flavour :mocha
              :color_overrides {:mocha retro-dark}
              :custom_highlights custom-highlights}})

; :custom_highlights (fn [colors]
;                      (set _G.colors colors)
;                      {:FzfLuaHeaderBind {:fg colors.lavender}
;                       :FzfLuaHeaderText {:fg colors.lavender}
;                       :TroubleCount {:fg colors.green}
;                       :CursorLine {:bg "#1E1E2E"}
;                       :CursorNr {:bg "#1E1E2E"}
;                       :CursorSign {:bg "#1E1E2E"}
;                       :TreesitterContext {:bg colors.mantle}
;                       :TroubleText {:bg colors.none}
;                       :TroubleFoldIcon {:bg colors.none}
;                       "@neorg.todo_items.pending" {:style [:altfont]}
;                       "@neorg.todo_items.on_hold" {:fg colors.blue
;                                                     :bg colors.none}})}})
;

