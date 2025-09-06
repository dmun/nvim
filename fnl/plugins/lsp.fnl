(import-macros {: add} :macros)
(local lsp vim.lsp)

(add {:source :mason-org/mason-lspconfig.nvim
      :depends [:mason-org/mason.nvim :neovim/nvim-lspconfig]})

(setup :mason)
(setup :mason-lspconfig)

(add :folke/lazydev.nvim)
(setup :lazydev)
(setup :lazydev {:library {:path "${3rd}/luv/library" :words ["vim%.uv"]}})

(lsp.config "*" {:root_markers [:.git]})

(lsp.config :lua_ls
            {:cmd [:lua-language-server]
             :filetypes [:lua]
             :root_markers [:init.lua :.luarc.json]
             :settings {:Lua {:definition {:showWord false}
                              :runtime {:version :LuaJIT}
                              :telemetry {:enable false}}}})

(lsp.config :ty
            {:cmd [:uv :run :ty :server]
             :filetypes [:python]
             :root_markers [:venv :.venv :pyproject.toml]
             :settings {:ty {:experimental {:completions {:enable true}}}}})

(lsp.config :pyrefly
            {:cmd [:pyrefly :lsp]
             :filetypes [:python]
             :root_markers [:venv :.venv :pyproject.toml]})

(lsp.config :rust-analyzer
            {:cmd [:rust-analyzer]
             :filetypes [:rust]
             :root_markers [:Cargo.toml]})

(lsp.config :tailwindcss
            {:cmd [:tailwindcss-language-server :--stdio]
             :filetypes [:html :svelte :postcss]
             :root_markers [:package.json]})

(lsp.config :ts_ls {:cmd [:typescript-language-server :--stdio]
                    :filetypes [:typescript
                                :typescriptreact
                                :javascript
                                :javascriptreact]
                    :root_markers [:package.json]})

(lsp.config :svelte_ls {:cmd [:svelteserver :--stdio]
                        :filetypes [:svelte]
                        :root_markers [:package.json]})

(lsp.config :godot {:cmd (vim.lsp.rpc.connect :127.0.0.1 (or (os.getenv :GDScript_Port) 6005))
                    :filetypes [:gdscript]})

(lsp.config :nixd {:cmd [:nixd] :filetypes [:nix]})

(lsp.config :qmlls {:cmd [:qmlls6 :-E] :root_markers [:shell.qml]})

(lsp.enable :lua_ls)
; (lsp.enable :ty)
(lsp.enable :pyrefly)
(lsp.enable :rust-analyzer)
(lsp.enable :tailwindcss)
(lsp.enable :ts_ls)
(lsp.enable :svelte_ls)
(lsp.enable :qmlls)
(lsp.enable :godot)
(lsp.enable :nixd)

(nmap :grr lsp.buf.references)
(nmap :gD lsp.buf.declaration)
(nmap :gd lsp.buf.definition)


