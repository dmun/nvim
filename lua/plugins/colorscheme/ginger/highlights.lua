local c = require("plugins.colorscheme.ginger.palette")

return {
	["dimmed"] = { ["inactive"] = "#444444", ["subtle"] = "#6e6e6e" },
	["accent"] = c.fg1,
	["border"] = c.fg2,
	["fg"] = c.fg1,
	["bg"] = { ["alt"] = c.bg.alt, ["base"] = c.bg.base, ["selected"] = c.bg.selected },
	["pum"] = {
		["sbar"] = c.accent,
		["sel"] = { fg = "none", bg = "#3e3e3e" },
		["bg"] = c.accent,
		["thumb"] = c.bg.alt,
	},
	["gitsigns"] = {
		["remove"] = c.red_fade,
		["add"] = c.green_fade,
		["change"] = c.yellow_fade,
	},
	["built_in"] = {
		["variable"] = c.green1,
		["function"] = c.green1,
		["constant"] = c.green1,
		["keyword"] = c.green1,
		["type"] = c.cyan2,
	},
	["syntax"] = {
		["function"] = c.cyan1,
		["property"] = c.fg0,
		["string"] = c.yellow,
		["number"] = c.yellow,
		["punctuation"] = c.fg2,
		["constructor"] = c.fg2,
		["keyword"] = c.yellow1,
		["constant"] = c.green1,
		["type"] = c.cyan2,
		["operator"] = c.fg1,
		["comment"] = c.fg4,
	},
}
