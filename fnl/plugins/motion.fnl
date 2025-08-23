(import-macros {: add} :macros)

(add :cbochs/grapple.nvim)
(let [grapple (require :grapple)]
  (grapple.setup {:icons false
                  :prune :2d
                  :win_opts {:width 56
                             :height 8
                             :border vim.o.winborder
                             :title_pos :left
                             :footer ""}})
  (nmap :<Leader>a grapple.tag)
  (nmap :<Leader>q grapple.toggle_tags)
  (nmap :<Leader>Q grapple.toggle_scopes)
  (for [i 1 5]
    (nmap (.. :<Leader> i) #(grapple.select {:index i}))))

(add :tpope/vim-rsi)
(add :jake-stewart/multicursor.nvim)
(let [mc (require :multicursor-nvim)]
  (mc.setup)
  (map [:n :x] :<C-q> mc.toggleCursor)
  (map :ga mc.matchAllAddCursors)
  (nmap :gm mc.restoreCursors)
  (xmap :q mc.visualToCursors)
  (xmap :m mc.matchCursors)
  (xmap :S mc.splitCursors)
  (map [:n :x] :<C-j> #(mc.lineAddCursor 1))
  (map [:n :x] :<C-k> #(mc.lineAddCursor -1))
  (map [:n :x] :<C-n> #(mc.matchAddCursor 1))
  (map [:n :x] :<C-p> #(mc.matchAddCursor -1))
  (map [:n :x] :gL #(mc.matchSkipCursor 1))
  (map [:n :x] :gH #(mc.matchSkipCursor -1))
  (mc.addKeymapLayer (fn [lmap]
                       (lmap [:n :x] :<C-o> mc.prevCursor)
                       (lmap [:n :x] :<C-i> mc.nextCursor)
                       (lmap [:n :x] :<C-h> mc.deleteCursor)
                       (lmap [:n :x] "=" mc.alignCursors)
                       (lmap [:n :x] :u :u)
                       (lmap [:n :x] :<C-r> :<C-r>)
                       (lmap :n :q
                             #(if (not (mc.cursorsEnabled))
                                  (mc.enableCursors)
                                  (mc.clearCursors))))))

(add :monaqa/dial.nvim)
(let [augend (require :dial.augend)
      augends (. (require :dial.config) :augends)
      dial (. (require :dial.map) :manipulate)]
  (augends:register_group {:default [augend.integer.alias.decimal
                                     augend.integer.alias.hex
                                     augend.constant.alias.bool
                                     (. augend.date.alias "%Y/%m/%d")]})
  (nmap :<C-a> #(dial :increment :normal))
  (nmap :<C-x> #(dial :decrement :normal))
  (nmap :g<C-a> #(dial :increment :gnormal))
  (nmap :g<C-x> #(dial :decrement :gnormal))
  (xmap :<C-a> #(dial :increment :visual))
  (xmap :<C-x> #(dial :decrement :visual))
  (xmap :g<C-a> #(dial :increment :gvisual))
  (xmap :g<C-x> #(dial :decrement :gvisual)))

