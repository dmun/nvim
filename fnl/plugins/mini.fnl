(let [extra (require :mini.extra)
      gen_ai_spec extra.gen_ai_spec]
  (setup :mini.ai
         {:custom_textobjects {:A (gen_ai_spec.buffer)
                               :D (gen_ai_spec.diagnostic)
                               :i (gen_ai_spec.indent)
                               :L (gen_ai_spec.line)
                               :N (gen_ai_spec.number)}}))

(let [misc (require :mini.misc)]
  (misc.setup)
  (misc.setup_auto_root)
  (misc.setup_restore_cursor))

(setup :mini.visits)
(setup :mini.extra)
(setup :mini.icons)
