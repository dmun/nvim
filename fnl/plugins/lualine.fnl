(import-macros {: se : hl : au : setup : plug} :macros)

;; fnlfmt: skip
(local c {:black        "#000000"
          :white        "#f2f2f2"
          :red          "#a60000"
          :green        "#006800"
          :blue         "#0031a9"
          :yellow       "#6f5500"
          :purple       "#313071"
          :gray         "#9f9f9f"
          :darkgray     "#595959"
          :lightgray    "#c8c8c8"})

;; fnlfmt: skip
(local theme {:normal   {:a {:bg c.purple    :fg c.white :gui :bold}
                         :b {:bg c.purple    :fg c.white}
                         :c {:bg c.purple    :fg c.white}}
              :insert   {:a {:bg c.purple    :fg c.white :gui :bold}
                         :b {:bg c.purple    :fg c.white}
                         :c {:bg c.purple    :fg c.white}}
              :visual   {:a {:bg c.purple    :fg c.white :gui :bold}
                         :b {:bg c.purple    :fg c.white}
                         :c {:bg c.purple    :fg c.white}}
              :replace  {:a {:bg c.purple    :fg c.white :gui :bold}
                         :b {:bg c.purple    :fg c.white}
                         :c {:bg c.purple    :fg c.white}}
              :command  {:a {:bg c.purple    :fg c.white :gui :bold}
                         :b {:bg c.purple    :fg c.white}
                         :c {:bg c.purple    :fg c.white}}
              :inactive {:a {:bg c.purple    :fg c.gray :gui :bold}
                         :b {:bg c.purple    :fg c.gray}
                         :c {:bg c.purple    :fg c.gray}}})

(local custom-filename {1 :filename
                        :path 4
                        :symbols {:unnamed :*scratch*
                                  :newfile :*scratch*
                                  :readonly ""
                                  :modified "󰏫"}})

;; fnlfmt: skip
(plug :nvim-lualine/lualine.nvim
      {:opts {:options {:theme theme
                        :component_separators {:left "" :right ""}
                        :section_separators {:left "" :right ""}
                        :always_divide_middle true
                        :disabled_filetypes [:Trouble :httpResult]}
              :sections {:lualine_a [:mode]
                         :lualine_b []
                         :lualine_c [custom-filename]
                         :lualine_x [:diagnostics :location]
                         :lualine_y []
                         :lualine_z []}
              :inactive_sections {:lualine_a [(fn [] "      ")]
                                  :lualine_b []
                                  :lualine_c [custom-filename]
                                  :lualine_x [:diagnostics :location]
                                  :lualine_y []
                                  :lualine_z []}}})

