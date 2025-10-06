(add {:source :saghen/blink.cmp
      :depends [:rafamadriz/friendly-snippets :folke/lazydev.nvim]
      :checkout :v1.6.0})

(local kind_hl_map {:Method "@function.method"
                    :Variable "@variable"
                    :Class "@lsp.type.class"
                    :Interface "@lsp.type.interface"
                    :Field "@variable.member"
                    :Function "@function.call"
                    :Constructor "@constructor"
                    :Module "@module"
                    :Property "@property"
                    :Enum "@lsp.type.enum"
                    :Keyword "@keyword"
                    :Delimiter "@tag.delimiter"
                    :File "@module"
                    :Constant "@constant"
                    :EnumMember "@lsp.type.enumMember"
                    :Struct "@lsp.type.struct"
                    :Operator "@operator"
                    :TypeParameter "@lsp.type.parameter"
                    :Text :Comment
                    :Unit :CmpItemKindUnit
                    :Value :CmpItemKindValue
                    :Color :CmpItemKindColor
                    :Reference :CmpItemKindReference
                    :Folder :CmpItemKindFolder
                    :Event :CmpItemKindEvent
                    :Snippet "Comment"})

(fn text [ctx]
  (let [paren (ctx.label:find "%(")]
    (if (vim.tbl_contains [:Method :Function] ctx.kind)
        (if (and (not paren) (not (vim.endswith ctx.label_detail ")")))
            (set ctx.label_detail "()")
            paren
            (do
              (set ctx.label_detail (ctx.label:sub paren (length ctx.label)))
              (set ctx.label (ctx.label:sub 1 (- paren 1))))))
    (.. ctx.label ctx.label_detail)))

(fn highlight [ctx]
  [{1 0
    2 (length ctx.label)
    :group (if ctx.deprecated :BlinkCmpLabelDeprecated
               (or (. kind_hl_map ctx.kind) :BlinkCmpKind))}])

(let [appearance {:nerd_font_variant :mono}
      keymap {:preset :none
              :<C-Space> [:show :show_documentation :hide_documentation]
              :<C-y> [:accept]
              :<Tab> [:accept :fallback]
              :<C-c> [:hide :fallback]
              :<C-p> [:select_prev :fallback]
              :<C-n> [:select_next :fallback]
              :<C-k> [:select_prev :fallback]
              :<C-j> [:show :select_next :fallback]
              :<C-u> [:scroll_documentation_up :fallback]
              :<C-d> [:scroll_documentation_down :fallback]
              :<C-f> [:snippet_forward :fallback]
              :<C-b> [:snippet_backward :fallback]}
      completion {:documentation {:auto_show false}
                  :accept {:dot_repeat false}
                  :list {:max_items 50}
                  :menu {:auto_show false
                         :border :none
                         :max_height vim.o.ph
                         :scrollbar false
                         :draw {:treesitter [:lsp]
                                :columns [[:label]]
                                :components {:label {: text : highlight}}}}}
      sources {:default [:lsp :path :snippets]
               :min_keyword_length 2
               :per_filetype {:sql [:dadbod :buffer]
                              :fennel [:buffer]}
                              ; :lua [:lazydev]}
               :providers {:dadbod {:name :Dadbod
                                    :module :vim_dadbod_completion.blink}
                           :lazydev {:name :LazyDev
                                     :module :lazydev.integrations.blink
                                     :score_offset 100}}}
      fuzzy {:implementation :prefer_rust_with_warning}
      blink (require :blink.cmp)]
  (blink.setup {: appearance : keymap : completion : sources : fuzzy}))

