Plug("tpope/vim-rsi")

Plug("ggandor/leap.nvim")
    :keys {
        { "s", "<Plug>(leap-forward)", { "n", "x", "o" } },
		{ "S", "<Plug>(leap-backward)", { "n", "x", "o" } },
		{ "gs", "<Plug>(leap-from-window)", { "n", "x", "o" } },
    }

Plug("justinmk/vim-sneak")
    :on(Event.VeryLazy)
    :keys {
		{ "f", "<Plug>Sneak_f" },
		{ "F", "<Plug>Sneak_F" },
		{ "t", "<Plug>Sneak_t" },
		{ "T", "<Plug>Sneak_T" },
	}
	:disabled()

Plug("nacro90/numb.nvim")
	:on(Event.CmdLineEnter)
	:opts()

Plug("jake-stewart/multicursor.nvim")
    :branch("1.0")
    -- :disabled()
    :config(function()
        local mc = require("multicursor-nvim")

        mc.setup {
            signs = {}
        }

        -- Add cursors above/below the main cursor.
        vim.keymap.set({"n", "v"}, "<C-k>", function()
            return ":lua for i=1," .. vim.v.count1 .. " do require('multicursor-nvim').addCursor('k') end<CR>"
        end, { expr = true, silent = true })

        vim.keymap.set({"n", "v"}, "<C-j>", function()
            return ":lua for i=1," .. vim.v.count1 .. " do require('multicursor-nvim').addCursor('j') end<CR>"
        end, { expr = true, silent = true })

        vim.keymap.set("v", "<C-g>", mc.visualToCursors)

        -- Add a cursor and jump to the next word under cursor.
        vim.keymap.set({"n", "v"}, "<c-n>", function() mc.addCursor("*") end)
        vim.keymap.set({"n", "v"}, "<c-p>", function() mc.addCursor("#") end)

        -- Jump to the next word under cursor but do not add a cursor.
        vim.keymap.set({"n", "v"}, "<c-s>", function() mc.skipCursor("*") end)

        -- Rotate the main cursor.
        vim.keymap.set({"n", "v"}, "<C-l>", mc.nextCursor)
        vim.keymap.set({"n", "v"}, "<C-h>", mc.prevCursor)

        -- Delete the main cursor.
        vim.keymap.set({"n", "v"}, "<leader>x", mc.deleteCursor)

        -- Add and remove cursors with control + left click.
        vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

        vim.keymap.set({"n", "v"}, "<c-q>", function()
            if mc.cursorsEnabled() then
                -- Stop other cursors from moving.
                -- This allows you to reposition the main cursor.
                mc.disableCursors()
            else
                mc.addCursor()
            end
        end)

        vim.keymap.set("n", "<esc>", function()
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
        vim.keymap.set("n", "<leader>a", mc.alignCursors)

        -- Split visual selections by regex.
        vim.keymap.set("v", "S", mc.splitCursors)

        -- Append/insert for each line of visual selections.
        vim.keymap.set("v", "I", mc.insertVisual)
        vim.keymap.set("v", "A", mc.appendVisual)

        -- match new cursors within visual selections by regex.
        vim.keymap.set("v", "M", mc.matchCursors)

        -- Rotate visual selection contents.
        vim.keymap.set("v", "<leader>t", function() mc.transposeCursors(1) end)
        vim.keymap.set("v", "<leader>T", function() mc.transposeCursors(-1) end)

        -- Customize how cursors look.
        vim.api.nvim_set_hl(0, "MultiCursorMainSign", {})
        vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
        vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
        vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end)
