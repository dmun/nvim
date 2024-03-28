(import-macros {: se : hl : au : setup : plug} :macros)

;; fnlfmt: skip
(local c {:black        "#1a1a1a"
          :white        "#dfdfdf"
          :red          "#EB5F6A"
          :green        "#AFCB85"
          :blue         "#52A7F6"
          :yellow       "#E5C995"
          :gray         "#535353"
          :darkgray     "#2a2a2a"
          :lightgray    "#6D6D6D"
          :inactivegray "#535353"})

(local theme {:normal {:a {:bg c.lightgray :fg c.white :gui :bold}
                       :b {:bg c.darkgray :fg c.white}
                       :c {:bg c.darkgray :fg c.white}}
              :insert {:a {:bg c.blue :fg c.black :gui :bold}
                       :b {:bg c.darkgray :fg c.white}
                       :c {:bg c.darkgray :fg c.white}}
              :visual {:a {:bg c.yellow :fg c.black :gui :bold}
                       :b {:bg c.darkgray :fg c.white}
                       :c {:bg c.darkgray :fg c.white}}
              :replace {:a {:bg c.red :fg c.black :gui :bold}
                        :b {:bg c.darkgray :fg c.white}
                        :c {:bg c.black :fg c.white}}
              :command {:a {:bg c.green :fg c.black :gui :bold}
                        :b {:bg c.darkgray :fg c.white}
                        :c {:bg c.darkgray :fg c.white}}
              :inactive {:a {:bg c.darkgray :fg c.lightgray :gui :bold}
                         :b {:bg c.darkgray :fg c.lightgray}
                         :c {:bg c.darkgray :fg c.lightgray}}})

;; fnlfmt: skip
(plug :nvim-lualine/lualine.nvim
      {:opts {:options {:theme theme
                        :component_separators {:left "" :right ""}
                        :section_separators {:left "" :right ""}
                        :always_divide_middle true
                        :disabled_filetypes [:Trouble :httpResult]}
              :sections {:lualine_a [:mode]
                         :lualine_b []
                         :lualine_c [{1 :filename
                                      :path 4
                                      :symbols {:unnamed :*scratch*
                                                :newfile :*scratch*}}]
                         :lualine_x [:diagnostics
                                     {1 :fileformat :icons_enabled false}
                                     :progress
                                     :location]
                         :lualine_y []
                         :lualine_z []}
              :inactive_sections {:lualine_a []
                                  :lualine_b []
                                  :lualine_c [(fn [] "      ")
                                              {1 :filename
                                               :path 4
                                               :symbols {:unnamed :*scratch*
                                                         :newfile :*scratch*}}]

                                  :lualine_x [:diagnostics
                                              {1 :fileformat
                                               :icons_enabled false}
                                              :progress
                                              :location]
                                  :lualine_y []
                                  :lualine_z []}}})

