-- issue: https://github.com/folke/neodev.nvim/issues/180
-- require("neodev").setup({
--   -- add any options here, or leave empty to use the default settings
-- })

require("rocks").packadd("mason")
require("rocks").packadd("mason-lspconfig")
require("rocks").packadd("lspconfig")

require("mason").setup()
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
	ensure_installed = { "lua_ls", "rust_analyzer" },
}

mason_lspconfig.setup_handlers {
	function(server_name)
		if server_name == "lua_ls" then
			require("rocks").packadd("neodev")
			require("neodev").setup()
		end

		lspconfig[server_name].setup {
			autostart = server_name ~= "ltex",
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					diagnostics = { globals = { "vim" } },
				},
				ltex = {
					language = "nl",
					filetype = { "norg" },
					additionalRules = { enablePickyRules = true },
				},
			},
		}
	end,
}

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").lua_ls.setup {}
-- require("lspconfig").rust_analyzer.setup {}
-- ...

-- lspconfig.lua_ls.setup {
-- 	on_init = function(client)
-- 		local path = client.workspace_folders[1].name
-- 		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
-- 			return
-- 		end
--
-- 		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using
-- 				-- (most likely LuaJIT in the case of Neovim)
-- 				version = "LuaJIT",
-- 			},
-- 			-- Make the server aware of Neovim runtime files
-- 			workspace = {
-- 				checkThirdParty = false,
-- 				library = {
-- 					vim.env.VIMRUNTIME,
-- 					-- Depending on the usage, you might want to add additional paths here.
-- 					-- "${3rd}/luv/library"
-- 					-- "${3rd}/busted/library",
-- 				},
-- 				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
-- 				-- library = vim.api.nvim_get_runtime_file("", true)
-- 			},
-- 		})
-- 	end,
-- 	settings = {
-- 		Lua = {},
-- 	},
-- }

-- lspconfig.rust_analyzer.setup {}
-- lspconfig.clangd.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
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
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		-- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>lf", function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
