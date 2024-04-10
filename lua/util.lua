local M = {}

function M.handle_keymaps(modes)
	for mode, maps in pairs(modes) do
		for _, map in pairs(maps) do
			vim.keymap.set(mode, map[1], map[2])
		end
	end
end

return M
