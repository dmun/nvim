local cmp = require("cmp")
local luasnip = require("luasnip")

vim.cmd("set completeopt=menu,menuone,noselect")

---checks if the character preceding the cursor is a space character
---@return boolean true if it is a space character, false otherwise
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

---checks if emmet_ls is available and active in the buffer
---@return boolean true if available, false otherwise
local is_emmet_active = function()
	local clients = vim.lsp.buf_get_clients()

	for _, client in pairs(clients) do
		if client.name == "emmet_ls" then
			return true
		end
	end
	return false
end

---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
---@param dir number 1 for forward, -1 for backward; defaults to 1
---@return boolean true if a jumpable luasnip field is found while inside a snippet
local function jumpable(dir)
	local luasnip_ok, luasnip = pcall(require, "luasnip")
	if not luasnip_ok then
		return
	end

	local win_get_cursor = vim.api.nvim_win_get_cursor
	local get_current_buf = vim.api.nvim_get_current_buf

	local function inside_snippet()
		-- for outdated versions of luasnip
		if not luasnip.session.current_nodes then
			return false
		end

		local node = luasnip.session.current_nodes[get_current_buf()]
		if not node then
			return false
		end

		local snip_begin_pos, snip_end_pos = node.parent.snippet.mark:pos_begin_end()
		local pos = win_get_cursor(0)
		pos[1] = pos[1] - 1 -- LuaSnip is 0-based not 1-based like nvim for rows
		return pos[1] >= snip_begin_pos[1] and pos[1] <= snip_end_pos[1]
	end

	---sets the current buffer's luasnip to the one nearest the cursor
	---@return boolean true if a node is found, false otherwise
	local function seek_luasnip_cursor_node()
		-- for outdated versions of luasnip
		if not luasnip.session.current_nodes then
			return false
		end

		local pos = win_get_cursor(0)
		pos[1] = pos[1] - 1
		local node = luasnip.session.current_nodes[get_current_buf()]
		if not node then
			return false
		end

		local snippet = node.parent.snippet
		local exit_node = snippet.insert_nodes[0]

		-- exit early if we're past the exit node
		if exit_node then
			local exit_pos_end = exit_node.mark:pos_end()
			if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end
		end

		node = snippet.inner_first:jump_into(1, true)
		while node ~= nil and node.next ~= nil and node ~= snippet do
			local n_next = node.next
			local next_pos = n_next and n_next.mark:pos_begin()
			local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
				or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

			-- Past unmarked exit node, exit early
			if n_next == nil or n_next == snippet.next then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end

			if candidate then
				luasnip.session.current_nodes[get_current_buf()] = node
				return true
			end

			local ok
			ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
			if not ok then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end
		end

		-- No candidate, but have an exit node
		if exit_node then
			-- to jump to the exit node, seek to snippet
			luasnip.session.current_nodes[get_current_buf()] = snippet
			return true
		end

		-- No exit node, exit from snippet
		snippet:remove_from_jumplist()
		luasnip.session.current_nodes[get_current_buf()] = nil
		return false
	end

	if dir == -1 then
		return inside_snippet() and luasnip.jumpable(-1)
	else
		return inside_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable()
	end
end

cmp.setup({
	snippet = {
		expand = function(args)
			--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
		-- ["<CR>"] = cmp.mapping.confirm({
		-- 	--behavior = cmp.ConfirmBehavior.Replace,
		-- 	select = true,
		-- }),
		["<TAB>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
			cmp.confirm({ select = true })
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif jumpable() then
				luasnip.jump(1)
			elseif check_backspace() then
				fallback()
			elseif is_emmet_active() then
				return vim.fn["cmp#complete"]()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	completion = {
		completeopt = "menu,menuone",
	},
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "cmp_tabnine" },
		{ name = "buffer" },
	}),
	formatting = {
		format = require("lspkind").cmp_format(),
	},
})
