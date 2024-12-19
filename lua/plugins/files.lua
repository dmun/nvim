local function get_clients(opts)
	local ret = {} ---@type vim.lsp.Client[]
	if vim.lsp.get_clients then
		ret = vim.lsp.get_clients(opts)
	else
		---@diagnostic disable-next-line: deprecated
		ret = vim.lsp.get_active_clients(opts)
		if opts and opts.method then
			---@param client vim.lsp.Client
			ret = vim.tbl_filter(function(client)
				return client.supports_method(opts.method, { bufnr = opts.bufnr })
			end, ret)
		end
	end
	return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

return {
	"airblade/vim-rooter",
	{
		"stevearc/oil.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = { { "-", "<cmd>Oil<cr>" } },
		opts = {
			view_options = {
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".") or vim.endswith(name, ".pdf")
				end,
			},
			win_options = {
				number = false,
				relativenumber = false,
				wrap = false,
				signcolumn = "yes",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		-- enabled = false,
		cmd = "FzfLua",
		keys = {
			{ "<leader>f", "<cmd>FzfLua files<cr>" },
			{ "<leader>l", "<cmd>FzfLua oldfiles<cr>" },
			{ "<leader>/", "<cmd>FzfLua live_grep<cr>" },
			{ "<leader>?", "<cmd>FzfLua live_grep_resume<cr>" },
			{ "<leader>,", "<cmd>FzfLua buffers<cr>" },
			{ "<leader>w", "<cmd>FzfLua lsp_document_symbols<cr>" },
			{ "<leader><leader>", "<cmd>FzfLua builtin<cr>" },
		},
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "fzf-lua" } })
				require("fzf-lua").register_ui_select(function(fzf_opts, items)
					return vim.tbl_deep_extend("force", fzf_opts, {
						prompt = "  ",
						winopts = {
							title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
							title_pos = "center",
						},
					}, fzf_opts.kind == "codeaction" and {
						winopts = {
							title = "",
							-- border = "none",
							relative = "cursor",
							row = 1,
							col = 0,
							width = 50,
							layout = "vertical",
							-- height is number of items minus 15 lines for the preview, with a max of 80% screen height
							height = #items + 1,
							-- height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 1) + 0.5),
							preview = not vim.tbl_isempty(get_clients({ bufnr = 0, name = "vtsls" })) and {
								layout = "vertical",
								vertical = "down:15,border-top",
								hidden = "hidden",
							} or {
								layout = "vertical",
								vertical = "down:15,border-top",
								hidden = "hidden",
							},
							on_create = function()
								vim.o.winhl = "Normal:Normal"
							end,
						},
					} or {
						winopts = {
							width = 0.5,
							-- height is number of items, with a max of 80% screen height
							height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
						},
					})
				end)
				return vim.ui.select(...)
			end
		end,
		opts = {
			defaults = {
				file_icons = false,
			},
			previewers = {
				builtin = {
					syntax_limit_b = 1024 * 100,
				},
			},
			files = {
				cwd_prompt = false,
				cmd = "rg --files --hidden",
				no_header_i = true,
				git_icons = false,
			},
			oldfiles = {
				include_current_session = true,
			},
			code_actions = {
				prompt = " > ",
			},
			grep = { no_header_i = true },
			buffers = { no_header_i = true },
			winopts = {
				border = "single",
				row = 0.4,
				col = 0.5,
				height = 0.6,
				width = 0.75,
				backdrop = 100,
				preview = {
					border = "noborder",
					hidden = "nohidden",
					vertical = "down:60%",
					title = false,
					scrollbar = false,
					scrollchars = { "┃", "" },
				},
			},
			fzf_opts = {
				["--info"] = "hidden",
				["--no-scrollbar"] = true,
			},
			-- fzf_colors = true,
			fzf_colors = {
				["fg"] = { "fg", "CursorLine" },
				-- ["bg"] = { "bg", "Normal" },
				["hl"] = { "fg", "Comment" },
				["fg+"] = { "fg", "Normal" },
				["bg+"] = { "bg", "CursorLine" },
				["hl+"] = { "fg", "Statement" },
				["info"] = { "fg", "PreProc" },
				["prompt"] = { "fg", "Label" },
				["pointer"] = { "bg", "CursorLine" },
				["marker"] = { "fg", "Keyword" },
				["spinner"] = { "fg", "Label" },
				["header"] = { "fg", "Comment" },
				["gutter"] = "-1",
			},
		},
	},
	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		keys = {
			{ "<leader>g", "<cmd>Grapple toggle_tags<cr>" },
			{ "<leader>m", "<cmd>Grapple tag<cr>" },
			{ "<M-1>", "<cmd>Grapple select index=1<cr>" },
			{ "<M-2>", "<cmd>Grapple select index=2<cr>" },
			{ "<M-3>", "<cmd>Grapple select index=3<cr>" },
			{ "<M-4>", "<cmd>Grapple select index=4<cr>" },
			{ "<M-5>", "<cmd>Grapple select index=5<cr>" },
		},
		opts = {
			scope = "cwd",
			statusline = {
				icon = "",
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		keys = {
			{ "<leader>e", "<cmd>NvimTreeOpen<cr>" },
		},
		opts = {
			view = {
				cursorline = false,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return {
						desc = "nvim-tree: " .. desc,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					}
				end

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set("n", "<M-e>", api.tree.close, opts("Close"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end,
		},
	},
}
