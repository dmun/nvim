(let [ai (require :mini.ai)
      extra (require :mini.extra)
      gen_ai_spec extra.gen_ai_spec]
  (ai.setup {:custom_textobjects {:A (gen_ai_spec.buffer)
                                  :D (gen_ai_spec.diagnostic)
                                  :i (gen_ai_spec.indent)
                                  :L (gen_ai_spec.line)
                                  :N (gen_ai_spec.number)}}))

(let [diff (require :mini.diff)]
  (diff.setup {:view {:style :sign}
               :mappings {:apply :mg
                          :reset :mG
                          :textobject :mg
                          :goto_first "[c"
                          :goto_prev "[c"
                          :goto_next "]c"
                          :goto_last "]c"}})
  (nmap :md MiniDiff.toggle_overlay))

(let [files (require :mini.files)]
  (files.setup {:mappings {:go_in_plus :l :go_out_plus :h}
                :windows {:max_number 3
                          :width_focus 30
                          :width_nofocus 30
                          :width_preview 30
                          :preview false}}))

(let [misc (require :mini.misc)]
  (misc.setup)
  (misc.setup_auto_root)
  (misc.setup_restore_cursor))

(let [visits (require :mini.visits)]
  (visits.setup))

(let [extra (require :mini.extra)]
  (extra.setup))

(let [icons (require :mini.icons)]
  (icons.setup))

(fn format-path [item]
  (let [file (vim.fs.basename item)
        dirname (vim.fs.dirname item)
        path (if (= dirname ".") ""
                 (.. "  " dirname "/"))]
    {:text (.. file path) :path item}))

(fn show-path [buf_id items query opts]
  (MiniPick.default_show buf_id items query {:show_icons false})
  (let [ns_id (. (vim.api.nvim_get_namespaces) :MiniPickRanges)]
    (each [row item (ipairs items)]
      (when item.path
        (let [offset_start (string.find item.text "  .*$")
              p -1]
          (when offset_start
            (pcall vim.api.nvim_buf_set_extmark buf_id ns_id (- row 1)
                   (+ offset_start p)
                   {:end_col (+ (vim.fn.strdisplaywidth item.text) p 1)
                    :hl_group :NonText
                    :hl_mode :combine
                    :priority 200})))))))

(local file-picker
       {:source {:name "Files (frecency)"
                 :show show-path
                 :items #(MiniPick.set_picker_items_from_cli [:rg
                                                              :--files
                                                              :--no-follow
                                                              :--color=never])}})

(let [pick (require :mini.pick)
      extra (require :mini.extra)]
  (pick.setup {:options {:use_cache true}
               ; :mappings {:move_down :<C-j> :move_up :<C-k>}
               :window {:prompt_caret "█"
                        :prompt_prefix "> "
                        :config #{:relative :editor
                                  :border ["" " " "" "" "" "" "" ""]
                                  :col 0
                                  :row (- vim.o.lines vim.o.ch 1)
                                  :width vim.o.columns
                                  :height (math.floor (- vim.o.lines
                                                         (/ vim.o.lines 1.615)))}}})
  (set vim.ui.select pick.ui_select)
  (nmap :g/ pick.builtin.grep_live)
  (nmap :g? pick.builtin.help)
  (nmap :<Leader><Leader> pick.builtin.resume)
  (nmap :<Leader>g extra.pickers.git_files)
  (nmap :<Leader>h extra.pickers.hl_groups)
  (nmap :<Leader>f #(pick.start file-picker))
  (nmap :gs #(extra.pickers.lsp {:scope :document_symbol}))
  (nmap :<Leader>o
        #(pick.start {:source {:name :Oldfiles
                               :show show-path
                               :items #(icollect [_ item (ipairs vim.v.oldfiles)]
                                         (if (= (vim.fn.filereadable item) 1)
                                             (format-path item)))}})))

