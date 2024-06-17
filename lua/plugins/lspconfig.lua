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
		autostart = config and config.autostart or true,
		on_init = config and config.on_init or nil,
		capabilities = vim.tbl_deep_extend(
			"force",
			require("cmp_nvim_lsp").default_capabilities() or {},
			config and config.capabilities or {}
		),
		handlers = {
			["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				signs = diagnostics.signs ~= false,
				virtual_text = diagnostics.virtual_text ~= false,
			}),
		},
	}
end

Plug("folke/lazydev.nvim")
	:ft("lua")

Plug("neovim/nvim-lspconfig")
	:on(Event.BufReadPre, Event.BufNewFile)
	:dependencies {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/lazydev.nvim",
	}
	:config(function()
		require("mason").setup()
		local lsp = require("lspconfig")
		local mason_lsp = require("mason-lspconfig")

		mason_lsp.setup {
			ensure_installed = Conf.lsp.ensure_installed,
		}

		-- setup mason language servers
		mason_lsp.setup_handlers {
			function(ls)
				lsp[ls].setup(get_ls_config(Conf.ls[ls]))
			end,
		}

		-- setup non-mason language servers
		for ls, _ in pairs(Conf.ls) do
			if not vim.tbl_contains(mason_lsp.get_available_servers(), ls) then
				lsp[ls].setup(get_ls_config(Conf.ls[ls]))
			end
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<CR>", "<cmd>FzfLua lsp_code_actions<cr>", opts)
			end,
		})
	end)
