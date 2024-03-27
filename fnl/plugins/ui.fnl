(import-macros {: se : hl : au : setup : plug} :macros)

; (plug :stevearc/dressing.nvim {:opts {}})

(plug :echasnovski/mini.starter
      {:enabled false :opts {:silent true :header nil :footer ""}})

(plug :j-hui/fidget.nvim {:opts {}})

(plug :onsails/lspkind.nvim
      {:config (fn []
                 (#$.init (require :lspkind)
                          {:symbol_map {:Text "󰉿"
                                        :Method "󰆧"
                                        :Function "󰊕"
                                        :Constructor ""
                                        :Field "󰜢"
                                        :Variable "󰀫"
                                        :Class "󰠱"
                                        :Interface ""
                                        :Module ""
                                        :Property "󰜢"
                                        :Unit "󰑭"
                                        :Value "󰎠"
                                        :Enum ""
                                        :Keyword "󰌋"
                                        :Snippet ""
                                        :Color "󰏘"
                                        :File "󰈙"
                                        :Reference "󰈇"
                                        :Folder "󰉋"
                                        :EnumMember ""
                                        :Constant "󰏿"
                                        :Struct "󰙅"
                                        :Event ""
                                        :Operator "󰆕"
                                        :TypeParameter ""}}))})

