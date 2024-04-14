return {
	"L3MON4D3/LuaSnip",
	lazy = true,
	cmd = "LuaSnipUnlinkCurrent",
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_snipmate").lazy_load()
	end,
	build = "make install_jsregexp",
}
