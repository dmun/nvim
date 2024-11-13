local c = {
	fg0 = "#ffffff",
	fg1 = "#dddddd",
	fg2 = "#bbbbbb",
	fg3 = "#999999",
	fg4 = "#777777",
	bg = {
		["alt"] = "#161616",
		["selected"] = "#202020",
		["base"] = "#000000",
	},
	accent = "#1f1f1f",
	blue = "#88DFFF",
	red = "#FF5189",
	purple = "#C8D7E8",
	cyan = "#88C1D0",
	cyan1 = "#05A8C5",
	cyan2 = "#4ECDC4",
	yellow = "#E9EE01",
	yellow1 = "#E3C78A",
	orange = "#E69E67",
	orange1 = "#FFAA43",
	green = "#9ECE6A",
	green1 = "#8FBE01",
	red_fade = "#261517",
	green_fade = "#15261b",
	yellow_fade = "#262415",
	blue_fade = "#152626",
}

return {
	-- 'maxmx03/solarized.nvim',
	{
		"oxfist/night-owl.nvim",
		config = function()
			require("night-owl").setup({
				italics = false,
			})
			vim.cmd("hi LeapLabel guifg=#f977a1 gui=bold")
		end,
	},
	{
		"ramojus/mellifluous.nvim",
		enabled = false,
		opts = {
			colorset = "mellifluous",
			mellifluous = {
				neutral = true,
				highlight_overrides = {
					dark = function(hl, colors)
						hl.set("IlluminatedWordText", { link = "CursorLine" })
						hl.set("IlluminatedWordRead", { link = "CursorLine" })
						hl.set("IlluminatedWordWrite", { link = "CursorLine" })
						hl.set("DiagnosticUnnecessary", { fg = colors.fg4 })
						hl.set("CursorLineNr", { link = "Normal" })
						hl.set("iCursor", { bg = "#88DFFF" })
						hl.set("LeapLabel", { fg = c.red })

						-- hl.set('NormalFloat', { link = 'Normal' })
						hl.set("TroubleNormal", { link = "Normal" })
						hl.set("FloatBorder", { fg = "#777777" })
						hl.set("GrappleNormal", { link = "Normal" })
						hl.set("FloatTitle", { fg = "#777777" })
						hl.set("TelescopeBorder", { link = "FloatBorder" })
						hl.set("FzfLuaBorder", { link = "FloatBorder" })
						hl.set("StatusLine", { bg = "#101010" })
						hl.set("StatusLineNC", { link = "StatusLine" })
						hl.set("VertSplit", { fg = "black" })
					end,
				},
			},
			flat_background = {
				line_numbers = true,
				floating_windows = false,
				file_tree = false,
				cursor_line_number = false,
			},
			plugins = {
				telescope = {
					nvchad_like = false,
				},
			},
		},
	},
	-- 'kaiuri/nvim-juliana',
	-- 'Mofiqul/vscode.nvim',
	-- 'bluz71/vim-moonfly-colors',
	-- { 'miikanissi/modus-themes.nvim', priority = 1000 },
	{
		"themercorp/themer.lua",
		priority = 1000,
		opts = {
			plugins = {
				cmp = false,
			},
			remaps = {
				palette = {
					nord = {
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
					},
				},
				highlights = {
					globals = {
						base = {
							IblIndent = { fg = c.bg.alt },
							-- Cursor = { fg = '#514F67' },
							-- iCursor = { bg = '#514F67' },
							-- iCursor = { bg = '#6E6A86' },
							-- Visual = { bg = '#3F3D52' },
							-- MultiCursorVisual = { bg = '#25233A' },
							-- Normal = { bg = '#000000' },
							SignColumn = { link = "Normal" },
							MultiCursorSign = { link = "LineNr" },
							CmpItemArgs = { fg = "#777777" },
							CmpItemMenu = { fg = c.fg2 },
							MoltenCell = { bg = "none" },
							MoltenOutputWin = { link = "Comment" },
							-- MoltenVirtualText       = { fg = '#55555e', bg = '#111116' },
							-- MoltenVirtualText       = { fg = c.fg3, bg = c.bg.alt },
							-- IlluminatedWordText = { link = 'ThemerFloat' },
							-- IlluminatedWordRead = { link = 'ThemerFloat' },
							-- IlluminatedWordWrite = { link = 'ThemerFloat' },
							FloatBorder = { fg = "#333338" },
							WinSeparator = { fg = "#333338" },
							FzfLuaFzfGutter = { bg = "#000000" },
							LeapLabel = { fg = c.red },
							LeapMatch = { fg = c.red },
							FzfLuaBorder = { link = "FloatBorder" },
							["@lsp.type.variable.zig"] = {},
						},
					},
				},
			},
		},
	},
	{
		"rachartier/tiny-devicons-auto-colors.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		"NvChad/nvim-colorizer.lua",
		cmd = "ColorizerAttachToBuffer",
		-- event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			filetypes = {
				"*",
				"!noice",
			},
			user_default_options = {
				names = false,
			},
		},
	},
	-- {
	-- 	'catppuccin/nvim',
	-- 	lazy = false,
	-- 	name = 'catppuccin',
	-- 	priority = 1000,
	-- 	opts = {
	-- 		---@param c CtpColors<CtpFlavor>
	-- 		custom_highlights = function(c)
	-- 			return {
	-- 				PmenuSel = { fg = c.none, bg = c.surface1, style = {} },
	-- 				-- Pmenu = { bg = c.mantle },
	-- 				CmpItemAbbr = { fg = c.text },
	-- 				CmpItemAbbrMatch = { fg = c.none, style = { 'bold' } },
	-- 				CmpItemAbbrMatchDefault = { link = 'CmpItemAbbrMatch' },
	-- 				CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
	-- 				CmpItemMenu = { fg = c.overlay2 },
	-- 				CmpItemArgs = { fg = c.overlay0 },
	--
	-- 				nCursor = { bg = c.peach },
	-- 				iCursor = { bg = c.green },
	--
	-- 				TreesitterContext = { bg = c.none },
	-- 				TreesitterContextLineNumber = { bg = c.none },
	-- 			}
	-- 		end,
	-- 	},
	-- },
	{
		"ellisonleao/gruvbox.nvim",
		enabled = false,
		opts = {
			contrast = "hard",
			bold = false,
			overrides = {
				iCursor = { bg = "#D3859B" },
				nCursor = { bg = "#FBBD2E" },
				-- CursorLineNr = { link = 'GruvboxYellow' },
				DiagnosticOk = { link = "GruvboxGreen" },
				PmenuSel = { link = "Cursorline" },
				CmpItemMenu = { fg = "#A79A84", bg = "none" },
				CmpItemArgs = { link = "Comment" },
				CmpItemAbbrMatch = { bold = true },
				CmpItemAbbrMatchFuzzy = { bold = true },
				-- SignColumn = { link = 'Normal' },
				LineNr = { fg = "#7c6f64", bg = "#3c3836" },
				GitSignsAdd = { link = "GruvboxGreenSign" },
				GitSignsChange = { link = "GruvboxAquaSign" },
				gitsignsdelete = { link = "gruvboxredsign" },

				diagnosticsignok = { link = "gruvboxgreen" },
				diagnosticsignhint = { link = "gruvboxaqua" },
				diagnosticsigninfo = { link = "gruvboxblue" },
				diagnosticsignwarn = { link = "gruvboxyellow" },
				diagnosticsignerror = { link = "gruvboxred" },

				treesittercontextlinenumber = { fg = "#7c6f64", sp = "#3c3836", underline = true },
				treesittercontext = { sp = "#3c3836", underline = true },

				diagnosticunderlineinfo = { sp = "#83a598", underline = true },
				diagnosticunderlinehint = { sp = "#8ec07c", underline = true },
				diagnosticunderlineerror = { sp = "#fb4934", underline = true },
				diagnosticunderlinewarn = { sp = "#fabd2f", underline = true },
			},
		},
	},
}
