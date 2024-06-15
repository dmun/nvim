return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			require("mason").setup()

			-- lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
			-- 	on_attach = function(client)
			-- 		client.server_capabilities.semanticTokensProvider = nil
			-- 	end,
			-- })

			mason_lspconfig.setup {
				ensure_installed = { "lua_ls" },
			}

			mason_lspconfig.setup_handlers {
				function(server_name)
					lspconfig[server_name].setup {
						autostart = server_name ~= "ltex",
						settings = {
							ltex = {
								-- language = "nl",
								filetype = { "norg", "typst" },
								additionalRules = { enablePickyRules = true },
								checkFrequency = "save",
								completionEnabled = true,
								latex = {
									commands = {
										["\\inline{}"] = "dummy",
									},
								},
							},
						},
						handlers = {
							["textDocument/publishDiagnostics"] = vim.lsp.with(
								vim.lsp.diagnostic.on_publish_diagnostics,
								{
									-- signs = false,
									virtual_text = server_name ~= "ltex",
								}
							),
						},
					}
				end,
				-- ["rust_analyzer"] = function() end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup {
						on_init = function(client)
							local path = client.workspace_folders[1].name
							if
								vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
							then
								return
							end

							client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
								runtime = {
									version = "LuaJIT",
								},
								-- Make the server aware of Neovim runtime files
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										-- Depending on the usage, you might want to add additional paths here.
										-- "${3rd}/luv/library"
										-- "${3rd}/busted/library",
									},
									-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
									-- library = vim.api.nvim_get_runtime_file("", true)
								},
							})
						end,
						settings = {
							Lua = {
								completion = { callSnippet = "Replace" },
								diagnostics = { globals = { "vim" } },
							},
						},
						handlers = {
							["textDocument/publishDiagnostics"] = vim.lsp.with(
								vim.lsp.diagnostic.on_publish_diagnostics,
								{
									-- signs = false,
								}
							),
						},
					}
				end,
			}

			lspconfig.sourcekit.setup {
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
				handlers = {
					["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
						-- signs = false,
					}),
				},
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
					-- vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					-- vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					-- vim.keymap.set("n", "<leader>wl", function()
					-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					-- end, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					-- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<CR>", "<cmd>FzfLua lsp_code_actions<cr>", opts)
				end,
			})
		end,
	},
}
