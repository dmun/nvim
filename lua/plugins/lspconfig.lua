local function get_ls_settings()
	local settings = {}

	for ls, ls_conf in pairs(Conf.ls) do
		settings[Conf.lsp.ls_name[ls] or ls] = ls_conf.settings
	end

	return settings
end

local function get_ls_config(config)
	local diagnostics = config and config.diagnostics or {}

	return {
		settings = get_ls_settings(),
		filetypes = config and config.filetypes or nil,
		autostart = config and (config.autostart ~= false),
		on_init = config and config.on_init or nil,
		capabilities = vim.tbl_deep_extend(
			"force",
			require("cmp_nvim_lsp").default_capabilities() or {},
			config and config.capabilities or {}
		),
		-- handlers = {
		-- 	["textDocument/publishDiagnostics"] = vim.lsp.with(
		-- 		vim.lsp.diagnostic.on_publish_diagnostics,
		-- 		vim.tbl_deep_extend("force", config and config.diagnostics or {}, {
		-- 			virtual_text = {
		-- 				prefix = "",
		-- 			},
		-- 		})
		-- 	),
		-- },
	}
end

return {
	{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	-- { 'mrcjkb/rustaceanvim', version = '^4' },
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/lazydev.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("mason").setup()
			local lsp = require("lspconfig")
			local mason_lsp = require("mason-lspconfig")

			require("lspconfig.configs").kotlin_lsp = {
				default_config = {
					filetypes = { "kotlin" },
					cmd = { "/Users/david/Development/kotlin-lsp/target/debug/kotlin-lsp" },
					root_dir = lsp.util.root_pattern(".git"),
				},
			}

			mason_lsp.setup({
				ensure_installed = Conf.lsp.ensure_installed,
			})

			-- setup mason language servers
			mason_lsp.setup_handlers({
				function(ls)
					lsp[ls].setup(get_ls_config(Conf.ls[ls]))
				end,
			})

			-- setup non-mason language servers
			for ls, _ in pairs(Conf.ls) do
				if not vim.tbl_contains(mason_lsp.get_available_servers(), ls) then
					lsp[ls].setup(get_ls_config(Conf.ls[ls]))
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<CR>", opts)
					vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<CR>", opts)
					vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>D", "<cmd>Trouble lsp_type_definitions<cr>", opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					-- vim.keymap.set("n", "<C-c>", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<C-c>", "<cmd>FzfLua lsp_code_actions<CR>", opts)
				end,
			})
		end,
	},
}
