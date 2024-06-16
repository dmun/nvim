Plug("NvChad/nvim-colorizer.lua")
	:on(Event.BufReadPre + Event.BufNewFile)
	:opts {
		user_default_options = {
			names = false,
		}
	}

return {
	-- "NvChad/nvim-colorizer.lua",
	-- event = { "BufReadPre", "BufNewFile" },
	-- opts = {
	-- 	user_default_options = {
	-- 		names = false,
	-- 	},
	-- },
}
