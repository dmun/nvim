return {
	"tpope/vim-rsi",
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", "<Plug>(leap-forward)", { "n", "x", "o" } },
			{ "S", "<Plug>(leap-backward)", { "n", "x", "o" } },
			{ "gs", "<Plug>(leap-from-window)", { "n", "x", "o" } },
		},
	},
	{
		"justinmk/vim-sneak",
		enabled = false,
		event = "VeryLazy",
		keys = {
			{ "f", "<Plug>Sneak_f" },
			{ "F", "<Plug>Sneak_F" },
			{ "t", "<Plug>Sneak_t" },
			{ "T", "<Plug>Sneak_T" },
		},
	},
	{
		"nacro90/numb.nvim",
		event = "CmdLineEnter",
		opts = {},
	},
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")
			local tbl = require("multicursor-nvim.tbl")
			local util = require("multicursor-nvim.util")

			local function matchCursors(pattern)
				mc.action(function(ctx)
					pattern = pattern or vim.fn.input("Match: ")
					if not pattern or pattern == "" then
						return
					end
					--- @type Cursor[]
					local newCursors = {}
					ctx:forEachCursor(function(cursor)
						if cursor:hasSelection() then
							newCursors = tbl.concat(newCursors, cursor:splitVisualLines())
						else
							newCursors[#newCursors + 1] = cursor
							cursor:setMode("v")
						end
					end)
					for _, cursor in ipairs(newCursors) do
						local selection = cursor:getVisualLines()
						local matches = util.matchlist(selection, pattern, {
							userConfig = true,
						})
						local vs = cursor:getVisual()
						for _, match in ipairs(matches) do
							if #match.text > 0 then
								local newCursor = cursor:clone()
								newCursor:setVisual(
									{ vs[1], vs[2] + match.byteidx + #match.text - 1 },
									{ vs[1], vs[2] + match.byteidx }
								)
								newCursor:feedkeys("o")
								-- newCursor:setMode("n")
							end
						end
						cursor:delete()
					end
				end)
			end

			mc.setup({ signs = false })

			local set = vim.keymap.set
			-- Add cursors above/below the main cursor.
			set({ "n", "v" }, "<C-k>", function()
				mc.lineAddCursor(-1)
			end)
			set({ "n", "v" }, "<C-j>", function()
				mc.lineAddCursor(1)
			end)

			set("v", "<C-c>", mc.visualToCursors)

			set({ "n", "v" }, "<C-n>", function()
				mc.matchAddCursor(1)
			end)
			set({ "n", "v" }, "<C-p>", function()
				mc.matchAddCursor(-1)
			end)
			set({ "n", "v" }, "<C-h>", mc.deleteCursor)

			-- Jump to the next word under cursor but do not add a cursor.
			set({ "n", "v" }, "<C-l>", function()
				mc.matchSkipCursor(1)
			end)

			set({ "n", "v" }, "<leader>M", mc.matchAllAddCursors)

			set({ "n", "v" }, "<C-q>", mc.toggleCursor)

			set("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
					vim.cmd("nohl")
				elseif mc.hasCursors() then
					mc.clearCursors()
					vim.cmd("nohl")
				else
					vim.cmd("nohl")
				end
			end)

			-- Align cursor columns.
			set("n", "<leader>a", mc.alignCursors)

			-- Split visual selections by regex.
			set("v", "S", mc.splitCursors)

			-- Append/insert for each line of visual selections.
			set("v", "I", mc.insertVisual)
			set("v", "A", mc.appendVisual)

			-- match new cursors within visual selections by regex.
			set("v", "s", matchCursors)
			set("n", "gm", mc.restoreCursors)

			-- Rotate visual selection contents.
			set("v", "<leader>t", function()
				mc.transposeCursors(1)
			end)
			set("v", "<leader>T", function()
				mc.transposeCursors(-1)
			end)

			-- Jumplist support
			set({ "v", "n" }, "<c-i>", mc.jumpForward)
			set({ "v", "n" }, "<c-o>", mc.jumpBackward)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorSign", { link = "LineNr", force = true })
			hl(0, "MultiCursorMainSign", { link = "CursorLineNr" })
			hl(0, "MultiCursorDisabledSign", { link = "LineNr" })
			hl(0, "MultiCursorCursor", { link = "Cursor" })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		end,
	},
}
