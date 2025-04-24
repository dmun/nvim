return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gs = require("gitsigns")
    local map = vim.keymap.set

    gs.setup({
      signs = {
        add = { text = "▍" },
        change = { text = "▍" },
        delete = { text = "▁" },
        topdelete = { text = "▔" },
        changedelete = { text = "▍" },
        untracked = { text = "┆" },
      },
      signcolumn = false,
      on_attach = function()
        map("n", "gs", function()
          if vim.o.signcolumn == "no" then
            vim.o.signcolumn = "yes"
            gs.toggle_signs(true)
          else
            vim.o.signcolumn = "no"
            gs.toggle_signs(false)
          end
        end)

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end)

        map("n", "<leader>hs", gs.stage_hunk)
        map("n", "<leader>hr", gs.reset_hunk)
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end)
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function() gs.diffthis("~") end)
        map("n", "<leader>td", gs.toggle_deleted)
      end,
    })
  end,
}
