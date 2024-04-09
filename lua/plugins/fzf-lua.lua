return {
	"ibhagwan/fzf-lua",
	config = function()
		local fzf = require("fzf-lua")

		vim.keymap.set("n", "<leader>f", fzf.files)
		vim.keymap.set("n", "<leader>of", fzf.oldfiles)
		vim.keymap.set("n", "<leader>/", fzf.live_grep_native)
		vim.keymap.set("n", "<leader>?", fzf.live_grep_resume)
		vim.keymap.set("n", "<leader>,", fzf.buffers)
		vim.keymap.set("n", "<leader><leader>", fzf.builtin)
	end,
}
