require'lspinstall'.setup()

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
		}
	}
end
