local M = {}

function M.handle_keymaps(modes)
	for mode, maps in pairs(modes) do
		for _, map in pairs(maps) do
			vim.keymap.set(mode, map[1], map[2])
		end
	end
end

---@param reset boolean?
function M.run_command(reset)
	local project_path = vim.fn.getcwd()
	local data_path = vim.fn.stdpath("data")

	local dir = data_path .. "/localleader-r" .. vim.fs.dirname(project_path)
	local basename = vim.fs.basename(project_path)
	local file = dir .. "/" .. basename .. ".json"

	if vim.loop.fs_stat(dir) == nil then
		vim.fn.mkdir(dir, "p")
	end

	if vim.loop.fs_stat(file) == nil then
		vim.cmd.write(file)
	end

	local fd, err, _ = vim.loop.fs_open(file, "r", 438)
	if err then
		print(err)
		return
	end

	---@diagnostic disable-next-line: redefined-local
	local fstat, err, _ = vim.loop.fs_fstat(fd)
	if err then
		print(err)
		return
	end

	---@diagnostic disable-next-line: redefined-local
	local data, err, _ = vim.loop.fs_read(fd, fstat.size, 0)
	if err then
		print(err)
		return
	end

	local command = nil

	if data then
		local ok, decoded = pcall(vim.json.decode, data)
		if not ok then
			print(decoded)
		end
		command = decoded.run
	end

	if command == nil or reset == true then
		vim.ui.input({
			prompt = "choose a run command: ",
		}, function(input)
			local encoded = vim.json.encode {
				run = input,
			}

			---@diagnostic disable-next-line: redefined-local
			local fd, err, _ = vim.loop.fs_open(file, "w", 438)
			if not data then
				print(err)
				return
			end

			vim.loop.fs_write(fd, encoded, 0)

			command = input
		end)
	end

	vim.cmd("split term://" .. command)
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.signcolumn = "no"
	vim.keymap.set("n", "q", "<cmd>bdelete<cr>", { buffer = true })
end

function M.run_command_reset()
	M.run_command(true)
end

return M
