Plug("airblade/vim-rooter")

Plug("stevearc/oil.nvim")
	:dependencies("nvim-tree/nvim-web-devicons")
	:keys { { "-", "<cmd>Oil<cr>" } }
	:opts {
		view_options = {
			is_hidden_file = function(name, bufnr)
				return vim.startswith(name, ".") or vim.endswith(name, ".pdf")
			end
		}
	}

Plug("ibhagwan/fzf-lua")
	:keys {
		{ "<leader>f", "<cmd>FzfLua files<cr>" },
		{ "<leader>l", "<cmd>FzfLua oldfiles<cr>" },
		{ "<leader>/", "<cmd>FzfLua live_grep<cr>" },
		{ "<leader>?", "<cmd>FzfLua live_grep_resume<cr>" },
		{ "<leader>,", "<cmd>FzfLua buffers<cr>" },
		{ "<leader><leader>", "<cmd>FzfLua builtin<cr>" },
	}
	:opts {
		files = {
			cmd = "rg --files --hidden",
			no_header_i = true,
			file_icons = false,
			-- git_icons = false,
		},
		grep = { no_header_i = true },
		buffers = { no_header_i = true },
		winopts = {
			split = "botright new",
			preview = { hidden = "hidden" }
		}
	}

Plug("cbochs/grapple.nvim")
	:dependencies {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	}
	:keys {
		{ "<leader>q", "<cmd>Grapple toggle_tags<cr>" },
		{ "<leader>m", "<cmd>Grapple tag<cr>" },
		{ "<leader>1", "<cmd>Grapple select index=1<cr>" },
		{ "<leader>2", "<cmd>Grapple select index=2<cr>" },
		{ "<leader>3", "<cmd>Grapple select index=3<cr>" },
		{ "<leader>4", "<cmd>Grapple select index=4<cr>" },
		{ "<leader>5", "<cmd>Grapple select index=5<cr>" },
	}
	:opts {
		scope = "cwd",
	}

Plug("nvim-tree/nvim-tree.lua")
	:disabled()
	:keys {
		{ "<leader>e", "<cmd>NvimTreeOpen<cr>" },
	}
	:opts {
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
	}
