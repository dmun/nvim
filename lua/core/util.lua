local M = {}

M.find_project_files = function()
	if vim.fn.isdirectory ".git" ~= 0 then
		require("telescope.builtin").find_files()
	else
		vim.cmd "Telescope projects"
	end
end

return M
