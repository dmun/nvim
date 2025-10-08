(let [extra (require :mini.extra)
      gen_ai_spec extra.gen_ai_spec]
  (setup :mini.ai {:custom_textobjects {:A (gen_ai_spec.buffer)
                                        :D (gen_ai_spec.diagnostic)
                                        :i (gen_ai_spec.indent)
                                        :L (gen_ai_spec.line)
                                        :N (gen_ai_spec.number)}}))

(setup :mini.files {:mappings {:go_in_plus :l :go_out_plus :h}
                    :windows {:max_number 3
                              :width_focus 30
                              :width_nofocus 30
                              :width_preview 30
                              :preview false}})

(let [misc (require :mini.misc)]
  (misc.setup)
  (misc.setup_auto_root)
  (misc.setup_restore_cursor))

(setup :mini.visits)
(setup :mini.extra)
(setup :mini.icons)

