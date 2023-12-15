vim.keymap.set("n", "<leader><leader>", function()
    -- if vim.fn.isdirectory ".git" ~= 0 then
        require("telescope.builtin").find_files()
    -- else
    --     vim.cmd "Telescope projects"
    -- end
end, { silent = true })
vim.keymap.set("n", "<leader>/", [[:lua require('telescope.builtin').live_grep()<CR>]], { silent = true })
vim.keymap.set("n", "<leader>,", [[:lua require('telescope.builtin').buffers()<CR>]], { silent = true })
vim.keymap.set("n", "<leader>.", [[:lua require('telescope.builtin').file_browser()<CR>]], { silent = true })
vim.keymap.set("n", "<leader>fh", [[:lua require('telescope.builtin').help_tags()<CR>]], { silent = true })
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { silent = true })
vim.keymap.set("n", "<leader>pp", ":Telescope projects<CR>", { silent = true })
vim.keymap.set("n", "<M-x>", ":Telescope keymaps<CR>", { silent = true })

local actions = require "telescope.actions"
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
        -- file_ignore_patterns = { "node_modules", ".git", ".aux", ".log", ".toc", ".gz", ".fls", ".pygtex" },
        -- prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        -- borderchars = {
        --     results = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
        --     prompt = { "▔", "▕", " ", "▏", "🭽", "🭾", "▕", "▏" },
        --     preview = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
        -- },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
    pickers = {
        find_files = {
            previewer = false,
            hidden = true,
            theme = 'dropdown',
        },
        live_grep = {
            previewer = false,
            hidden = true,
            theme = 'dropdown',
        },
        buffers = {
            previewer = false,
            hidden = true,
            theme = 'dropdown',
        },
        oldfiles = {
            previewer = false,
            hidden = true,
            theme = 'dropdown',
        },
        file_browser = {
            previewer = false,
            hidden = true,
            theme = 'dropdown',
        },
        help_tags = {
            previewer = false,
            theme = 'dropdown',
        },
        keymaps = {
            previewer = false,
            theme = 'dropdown',
        },
    },
}

-- require('telescope').load_extension "file_browser"
require("project_nvim").setup()
require("telescope").load_extension "projects"
-- require 'telescope'.load_extension('project')
