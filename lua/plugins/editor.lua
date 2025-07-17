-- local function _3_()
-- 	local filter = { "sql" }
-- 	if (vim.bo.buftype == "") and not vim.tbl_contains(filter, vim.bo.filetype) then
-- 		if AutosaveTimer then
-- 			AutosaveTimer:stop()
-- 		else
-- 			AutosaveTimer = vim.uv.new_timer()
-- 		end
--
-- 		local function _5_()
-- 			local function _6_()
-- 				return vim.cmd("silent! update")
-- 			end
-- 			vim.schedule(_6_)
-- 			AutosaveTimer:stop()
-- 			AutosaveTimer:close()
--
-- 			AutosaveTimer = nil
-- 		end
-- 		return AutosaveTimer:start(250, 0, _5_)
-- 	else
-- 		return nil
-- 	end
-- end
-- vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, { callback = _3_, pattern = "*" })

add("tpope/vim-sleuth")
add("stevearc/conform.nvim")
add("stevearc/quicker.nvim")

-- add("jpalardy/vim-slime")
-- vim.g.slime_target = "tmux"
-- vim.g.slime_bracketed_paste = 1

-- nmap("ms", "<Plug>SlimeParagraphSend")
-- nmap("mR", "<Plug>SlimeLineSend")
-- map("mr", "<Plug>SlimeLineSend")

add("eraserhd/parinfer-rust")

add("windwp/nvim-autopairs")
require("nvim-autopairs").setup({})

vim.g.nvim_ghost_autostart = 0
add("subnut/nvim-ghost.nvim")
nmap("mg", cmd.GhostTextStart)

vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", { clear = false })
au("User", "*kaggle*", function()
  vim.bo.ft = "python"
end, "nvim_ghost_user_autocommands")

au("User", "ghosttext.fregante.com", function()
  vim.bo.ft = "javascript"
end, "nvim_ghost_user_autocommands")

require("conform").setup({
  formatters_by_ft = {
    -- qml = { "qmlformat" },
    jsonc = { "prettier" },
    css = { "prettier" },
    fennel = { "fnlfmt" },
    svelte = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    lua = { "stylua" },
  },
  formatters = {
    qmlformat = {
      command = "qmlformat",
    },
  },
})

require("quicker").setup({
  opts = {
    signcolumn = "no",
  },
})

nmap("mf", function()
  require("conform").format({ lsp_format = "fallback" })
end)
