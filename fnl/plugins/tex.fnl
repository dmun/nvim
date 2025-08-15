(add {:source :Thiago4532/mdmath.nvim
      :depends [:nvim-treesitter/nvim-treesitter]})

(let [mdmath (require :mdmath)]
  (mdmath.setup {:hide_on_insert false
                 :dynamic_scale 0.67}))
