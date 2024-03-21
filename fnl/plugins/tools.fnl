(import-macros {: plug : setup : nmap} :macros)

(plug :vhyrro/luarocks.nvim
      {:branch :go-away-python
       :opts {:rocks [:lua-curl :nvim-nio :mimetypes :xml2lua]}})

(plug :rest-nvim/rest.nvim
      {:ft :http
       :dependencies [:vhyrro/luarocks.nvim]
       :opts {:result {:split {:horizontal true}}}
       :config (fn [_ opts]
                 (setup :rest-nvim opts)
                 (nmap <localleader>r "<cmd>Rest run<cr>"))})

