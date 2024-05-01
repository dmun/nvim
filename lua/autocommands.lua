-- highlight on yank
local hi_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = hi_group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- auto-save
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd("silent update")
		end
	end,
})

-- clear cmdline
vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = function()
		vim.fn.timer_start(1000, function()
			print(" ")
		end)
	end,
})

-- filetype handling
vim.cmd("au BufRead,BufNewFile *.conf se ft=conf")

-- dynamic linenumbers
if false then
	vim.cmd("au InsertEnter * se nornu")
	vim.cmd("au InsertLeave * se rnu")
end

-- dynamic CursorLineNr color
vim.cmd("au InsertEnter * se winhl=CursorLineNr:iCursorLineNr")
vim.cmd("au InsertLeave * se winhl=CursorLineNr:nCursorLineNr")

-- vim.api.nvim_create_autocmd("TextChangedI", {
-- 	callback = function()
-- 		if vim.bo.buftype == "" then
-- 			local lines = vim.api.nvim_buf_line_count(0) - 1
-- 			local win_height = vim.api.nvim_win_get_height(0)
-- 			local namespace = vim.api.nvim_create_namespace("bruh")
-- 			vim.api.nvim_buf_set_extmark(0, namespace, lines, 0, {
-- 				id = 69,
-- 				-- virt_text_pos = "overlay",
-- 				virt_lines_leftcol = true,
-- 				ui_watched = true,
-- 				virt_lines = {
-- 					{ { "    ~ ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 					{ { "      ", "LineNr" } },
-- 				},
-- 				priority = 999,
-- 				right_gravity = false,
-- 				strict = false,
-- 				-- sign_text = "br",
-- 			})
-- 		end
-- 	end,
-- })
