Conf.lsp = {
	ensure_installed = { "lua_ls" },
	ls_name = { lua_ls = "Lua" },
}

Conf.ls.kotlin_lsp = {}

Conf.ls.ltex = {
	filetypes = { "tex", "typst", "markdown" },
	autostart = false,
	diagnostics = { virtual_text = false },
	settings = {
		-- language = "nl",
		additionalRules = { enablePickyRules = true },
		checkFrequency = "save",
		completionEnabled = true,
		latex = { commands = { ["\\inline{}"] = "dummy" } },
	},
}

Conf.ls.sourcekit = {
	capabilities = {
		workspace = {
			didChangeWatchedFiles = { dynamicRegistration = true },
		},
	},
}

Conf.ls.lua_ls = {
	settings = {
		completion = { callSnippet = "Replace" },
		diagnostics = { globals = { "vim" } },
	},
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
					"${3rd}/busted/library",
					-- "~/.local/share/nvim/lazy/"
				},
			},
		})
	end,
}
