local M = {}

M.find_project_files = function ()
    if vim.fn.isdirectory('.git') ~= 0 then
        require('telescope.builtin').git_files()
    else
        require('telescope.builtin').find_files()
    end
end

return M
