return {
	"epwalsh/obsidian.nvim",
	ft = "markdown",
	keys = {
		{ "<leader>oo", "<cmd>ObsidianOpen<cr>" },

		{ "<leader>of", "<cmd>ObsidianQuickSwitch<cr>" },
		{ "<leader>ob", "<cmd>ObsidianBacklinks<cr>" },

		{ "<leader>on", "<cmd>ObsidianNew<cr>" },
		{ "<leader>od", "<cmd>ObsidianToday<cr>" },
		{ "<leader>om", "<cmd>ObsidianTomorrow<cr>" },
		{ "<leader>oy", "<cmd>ObsidianYesterday<cr>" },

		{ "<leader>ot", "<cmd>ObsidianTemplate<cr>" },
	},
	dependencies = "nvim-lua/plenary.nvim",
	opts = {
		ui = {
			enable = true,
		},
		completion = {
			nvim_cmp = false,
		},
		workspaces = {
			{
				name = "default",
				path = os.getenv("OBSIDIAN_VAULT"),
			},
		},
		templates = {
			subdir = "templates",
		},
		disable_frontmatter = true,
		note_id_func = function(title)
			if title ~= nil then
				return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				local suffix = ""
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
				return tostring(os.time()) .. "-" .. suffix
			end
		end,
	},
}
