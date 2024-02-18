(import-macros {: se : hl : au : setup : plug} :macros)

(hl Sneak {:guifg "#FF007C" :gui "underline,nocombine"})

;; fnlfmt: skip
(plug :catppuccin/nvim
      {:lazy false
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
                                    :CursorLine {:bg "#2A2B3E"}
                                    :CursorNr {:bg "#2A2B3E"}
                                    :CursorSign {:bg "#2A2B3E"}
                                    :TreesitterContext {:bg colors.mantle}
                                    :TroubleText {:bg colors.none}
                                    :TroubleFoldIcon {:bg colors.none}
                                    :CursorInsert {:bg colors.green}
                                    :Cursor {:bg colors.rosewater}
                                    :Cursor {:bg colors.rosewater}
                                    "@neorg.todo_items.pending" {:style [:altfont]}
                                    "@neorg.todo_items.on_hold" {:fg colors.blue
                                                                  :bg colors.none}})}})

(plug :norcalli/nvim-colorizer.lua)

(plug :bluz71/vim-moonfly-colors
      {:enabled false
       :priority 1000
       :config (fn [] (vim.cmd.colorscheme :moonfly))})

