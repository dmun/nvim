return {
	-- 'romainl/vim-cool',
	-- 'echasnovski/mini.nvim',
	{ "numToStr/Comment.nvim", event = "VeryLazy" },
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "nonerdfont",
				hi = {
					background = "None",
				},
				signs = {
					left = "",
					right = "",
					diag = "",
					arrow = "",
					up_arrow = "",
					vertical = "",
					vertical_end = "",
				},
			})
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
	{
		"dgagn/diagflow.nvim",
		enabled = false,
		event = "LspAttach",
		opts = {
			scope = "cursor",
			padding_right = 2,
			toggle_event = { "InsertEnter", "InsertLeave" },
		},
	},
	{
		"kylechui/nvim-surround",
		enabled = false,
		event = "VeryLazy",
		opts = {
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "s",
				normal_cur = "ss",
				normal_line = "S",
				normal_cur_line = "SS",
				visual = "s",
				visual_line = "S",
				delete = "ds",
				change = "cs",
				change_line = "cS",
			},
		},
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{
		"dstein64/nvim-scrollview",
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
		name = "ibl",
		opts = {
			indent = {
				char = "▏",
			},
			scope = { enabled = false },
		},
	},
	{
		"RRethy/vim-illuminate",
		enabled = false,
		config = function()
			require("illuminate").configure({
				providers = { "lsp" },
				large_file_cutoff = 1000,
				large_file_overrides = {
					providers = { "lsp" },
				},
			})
		end,
	},
	{
		"NMAC427/guess-indent.nvim",
		-- enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"kosayoda/nvim-lightbulb",
		enabled = false,
		opts = {
			autocmd = { enabled = true },
			sign = {
				text = "",
				hl = "DiagnosticWarn",
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufRead", "BufNewFile" },
		dependencies = { "kevinhwang91/promise-async", "kiyoon/jupynium.nvim" },
		opts = {
			provider_selector = function(bufnr, ft, bt)
				local ufo = require("ufo")
				local function get_cell_folds(bufnr)
					local function handleFallbackException(err, providerName)
						if type(err) == "string" and err:match("UfoFallbackException") then
							return ufo.getFolds(bufnr, providerName)
						else
							return require("promise").reject(err)
						end
					end
					return ufo.getFolds(bufnr, "lsp")
						:catch(function(err)
							return handleFallbackException(err, "treesitter")
						end)
						:catch(function(err)
							return handleFallbackException(err, "indent")
						end)
						:thenCall(function(ufo_folds)
							local ok, jupynium = pcall(require, "jupynium")
							if ok then
								for _, fold in ipairs(jupynium.get_folds()) do
									table.insert(ufo_folds, fold)
								end
							end
							return ufo_folds
						end)
				end
				if ft == "python" then
					return get_cell_folds
				end
				return { "treesitter", "indent" }
			end,
		},
	},
	{
		"folke/trouble.nvim",
		opts = {
			focus = true,
		},
	},
}
