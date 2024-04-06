(import-macros {: se : hl : au : setup : plug} :macros)

;; fnlfmt: skip
(local modus {:black     "#000000"
              :white     "#f2f2f2"
              :red       "#a60000"
              :green     "#006800"
              :blue      "#0031a9"
              :yellow    "#6f5500"
              :purple    "#313071"
              :gray      "#8A8AC1"
              :darkgray  "#595959"
              :lightgray "#c8c8c8"})

;; fnlfmt: skip
(local c {:black     "#181818"
          :white     "#dfdfdf"
          :red       "#EB5F6A"
          :green     "#AFCB85"
          :blue      "#52a7f6"
          :cyan      "#78d0bd"
          :yellow    "#E5C995"
          :purple    "#D898D8"
          :gray      "#2d2d2d"
          :darkgray  "#595959"
          :lightgray "#c8c8c8"})

;; fnlfmt: skip
(local theme {:normal   {:a {:bg c.green  :fg c.black :gui :bold}
                         :b {:bg c.gray   :fg c.white}
                         :c {:bg c.gray   :fg c.white}}
              :insert   {:a {:bg c.purple :fg c.black :gui :bold}
                         :b {:bg c.gray   :fg c.white}
                         :c {:bg c.gray   :fg c.white}}
              :visual   {:a {:bg c.white  :fg c.black :gui :bold}
                         :b {:bg c.gray   :fg c.white}
                         :c {:bg c.gray   :fg c.white}}
              :replace  {:a {:bg c.yellow :fg c.black :gui :bold}
                         :b {:bg c.gray   :fg c.white}
                         :c {:bg c.gray   :fg c.white}}
              :command  {:a {:bg c.white  :fg c.black :gui :bold}
                         :b {:bg c.gray   :fg c.white}
                         :c {:bg c.gray   :fg c.white}}
              :inactive {:a {:bg c.gray   :fg c.darkgray :gui :bold}
                         :b {:bg c.gray   :fg c.darkgray}
                         :c {:bg c.gray   :fg c.darkgray}}})

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
                        :disabled_filetypes [:Trouble :httpResult :fzf]}
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

