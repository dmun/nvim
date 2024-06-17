local Vec = require("util.vector")

-- filetypes
vim.cmd("au BufRead,BufEnter *.swiftinterface se ft=swift")
vim.cmd("au BufRead,BufEnter .swift-format se ft=json")

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

-- dynamic linenumbers
if false then
	vim.cmd("au InsertEnter * se nornu")
	vim.cmd("au InsertLeave * se rnu")
end

-- dynamic CursorLineNr color
if false then
	vim.cmd("au InsertEnter * se winhl=CursorLineNr:iCursorLineNr")
	vim.cmd("au InsertLeave * se winhl=CursorLineNr:nCursorLineNr")
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local rgb = require("polychrome.color.rgb")
		local oklch = require("polychrome.color.oklch")

		local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
		local normal_bg = string.format("#%06x", hl.bg)

		local p1 = Vec(0, 1)
		local p2 = Vec(0.1, 0)
		local p3 = Vec(0, 0)
		local p4 = Vec(0.3, 0)

		local bg = rgb:from_hex(normal_bg):to(oklch) ---@cast bg Oklch
		local value = Vec.cubic_bezier(p1, p2, p3, p4, bg.L)[2]
		bg.L = bg.L + value * 0.15
		bg.c = bg.c + value * 0.05

		local error_bg = vim.deepcopy(bg)
		error_bg.h = bg.h + 30

		local warn_bg = vim.deepcopy(bg)
		warn_bg.h = bg.h + 85

		vim.cmd("hi! DiagnosticSignLineWarn guibg=" .. warn_bg:hex())
		vim.cmd("hi! DiagnosticSignLineError guibg=" .. error_bg:hex())

		hl = vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false })
		local error_fg = string.format("#%06x", hl.fg)
		vim.cmd("hi! DiagnosticError guifg=" .. error_fg)
		vim.cmd("hi! link DiagnosticVirtualTextError DiagnosticError")

		hl = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false })
		local warn_fg = string.format("#%06x", hl.fg)
		vim.cmd("hi! DiagnosticWarn guifg=" .. warn_fg)
		vim.cmd("hi! link DiagnosticVirtualTextWarn DiagnosticWarn")
	end,
})
