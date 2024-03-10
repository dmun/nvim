(import-macros {: se : hl : au : setup : plug} :macros)

; (plug :stevearc/dressing.nvim {:opts {}})

(plug :echasnovski/mini.starter
      {:enabled false :opts {:silent true :header nil :footer ""}})

(plug :j-hui/fidget.nvim {:opts {}})

(plug :nvim-lualine/lualine.nvim
      {:opts {:options {:theme :auto
                        :component_separators {:left "" :right ""}
                        :section_separators {:left "" :right ""}
                        :always_divide_middle true}
              :sections {:lualine_a []
                         :lualine_b []
                         :lualine_c [:mode :filename]
                         :lualine_x [:diagnostics
                                     {1 :fileformat :icons_enabled false}
                                     :progress
                                     :location]
                         :lualine_y []
                         :lualine_z []}
              :inactive_sections {:lualine_a []
                                  :lualine_b []
                                  :lualine_c [(fn [] "      ") :filename]
                                  :lualine_x [:diagnostics
                                              {1 :fileformat
                                               :icons_enabled false}
                                              :progress
                                              :location]
                                  :lualine_y []
                                  :lualine_z []}}})

