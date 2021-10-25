require'lspinstall'.setup()
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
	require'lspconfig'[server].setup {
		settings = {
			Lua = {
				diagnostics = {
					globals = {
						'vim',
						'use',
						'awesome',
						'screen',
						'client',
						'root',
						'keys',
						'hotkeys_popup',
					}
				}
			}
		},
        capabilities = capabilities,
	}
end
