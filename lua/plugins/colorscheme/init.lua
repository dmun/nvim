local palette = require("plugins.colorscheme.night-owl.highlights")

return {
	{
		"oxfist/night-owl.nvim",
		config = function()
			require("night-owl").setup({ italics = false })
			-- vim.cmd("hi FlashLabel guifg=#FE2C83 gui=bold")
			-- vim.cmd("hi link FlashCurrent CurSearch")
			-- vim.cmd("hi iCursor guibg=#FF869A gui=bold")
			-- vim.cmd("hi nCursor guibg=#FF869A gui=bold")
		end,
	},
	{
		"miikanissi/modus-themes.nvim",
		priority = 1000,
		config = function()
			require("modus-themes").setup({
				variant = "tinted",
				styles = {
					variables = { link = "lispSymbol" },
				},
				---@param colors ColorScheme
				on_colors = function(colors)
					colors.bg_active = "#141528"
				end,
				---@param hl Highlights
				---@param c ColorScheme
				on_highlights = function(hl, c)
					hl.PmenuSel = { bg = c.bg_inactive }
					hl.Pmenu = { bg = c.bg_dim }
					hl.PmenuThumb = { bg = c.border }
					hl.BlinkCmpDoc = { bg = c.bg_active }
					hl.BlinkCmpDocSeparator = { fg = c.fg_dim }
					hl.BlinkCmpDocBorder = { bg = c.bg_active }

					-- hl.PmenuSbar = { bg = c.bg_inactive }
					hl.CursorLine = { bg = c.bg_dim }
					hl.CursorLineSign = { bg = c.bg_dim }
					hl.CursorLineNr = { bg = c.bg_dim }
					hl.LineNr = { fg = c.bg_inactive }

					hl.NoiceCmdline = { bg = c.bg_inactive }

					hl.GitSignsAdd = { fg = c.bg_added }
					hl.GitSignsChange = { fg = c.bg_changed }
					hl.GitSignsDelete = { fg = c.bg_removed }

					hl.Visual = { bg = c.bg_inactive }
					hl.Search = { bg = c.bg_inactive }
					hl.NormalTerm = { bg = c.bg_active }

					hl.nCursor = { bg = c.red_cooler }
					hl.iCursor = { bg = c.magenta_intense }
					hl.NormalFloat = { bg = c.bg_dim }

					hl.CursorLineNr = { fg = c.fg_alt }
					hl.LineNrAbove = { link = "LineNr" }
					hl.LineNrBelow = { link = "LineNr" }

					hl.LeapBackdrop = {}
					hl.LeapLabel = { fg = c.magenta_intense }

					-- hl.FzfLuaNormal = { bg = c.bg_active }
				end,
			})
		end,
	},
	{
		"themercorp/themer.lua",
		priority = 1000,
		opts = {
			remaps = {
				palette = {
					boo = palette,
				},
				highlights = {
					globals = {
						base = {
							Cursor = { bg = palette.bg.base, fg = palette.fg },
							iCursor = { fg = palette.bg.base, bg = palette.fg },
							nCursor = { fg = palette.bg.base, bg = palette.fg },
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
		-- cmd = "ColorizerAttachToBuffer",
		event = { "BufReadPre", "BufNewFile" },
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
		-- enabled = false,
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
