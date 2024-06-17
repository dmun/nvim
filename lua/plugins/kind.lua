Plug("onsails/lspkind.nvim")
	:config(function()
		require("lspkind").init {
			symbol_map = {
				Text = " ",
				Snippet = " ",
				Method = "󰰐",
				Function = "󰯻",
				Constructor = "󰯲",
				Field = "󰯻",
				Variable = "󰰫",
				Class = "󰯲",
				Interface = "󰰄",
				Module = "󰰐",
				Property = "󰰙",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "󰯸",
				Keyword = "󰰊",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "󰯸",
				Constant = "󰬊",
				Struct = "󰰢",
				Event = "󰯸",
				Operator = "󰆕",
				TypeParameter = "",
			}
		}
	end)
