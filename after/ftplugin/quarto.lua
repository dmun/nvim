local api = vim.api
local ts = vim.treesitter

vim.keymap.set('n', '<CR>', '<cmd>QuartoSend<cr>', { buffer = 0 })

-- vim.g.molten_virt_lines_off_by_1 = true
vim.b.slime_cell_delimiter = '```'
vim.b['quarto_is_r_mode'] = nil
vim.b['reticulate_running'] = false
vim.o.isk = '@,48-57,_,192-255'

-- wrap text, but by word no character
-- indent the wrappped line
vim.cmd('setl cole=0')

-- don't run vim ftplugin on top
vim.api.nvim_buf_set_var(0, 'did_ftplugin', true)

-- markdown vs. quarto hacks
local ns = vim.api.nvim_create_namespace 'QuartoHighlight'
vim.api.nvim_set_hl(ns, '@markup.strikethrough', { strikethrough = false })
vim.api.nvim_set_hl(ns, '@markup.doublestrikethrough', { strikethrough = true })
vim.api.nvim_win_set_hl_ns(0, ns)

-- ts based code chunk highlighting uses a change
-- only availabl in nvim >= 0.10
if vim.fn.has 'nvim-0.10.0' == 0 then
	return
end

-- highlight code cells similar to
-- 'lukas-reineke/headlines.nvim'
-- (disabled in lua/plugins/ui.lua)
local buf = api.nvim_get_current_buf()

local parsername = 'markdown'
local parser = ts.get_parser(buf, parsername)
local tsquery = '(fenced_code_block)@codecell'

-- vim.api.nvim_set_hl(0, '@markup.codecell', { bg = '#000055' })
vim.api.nvim_set_hl(0, '@markup.codecell', {
	link = 'MoltenCell',
})

-- vim.api.nvim_set_hl(0, '@markup.codecell', { bg = '#000055' })
vim.api.nvim_set_hl(0, '@markup.codecell.lang', {
	fg = '#333338',
	bg = '#111116',
})

-- vim.api.nvim_set_hl(0, '@markup.codecell', { bg = '#000055' })
vim.api.nvim_set_hl(0, '@markup.codecell.end', {
	fg = 'black',
	bg = 'black',
})

local function clear_all()
	local all = api.nvim_buf_get_extmarks(buf, ns, 0, -1, {})
	for _, mark in ipairs(all) do
		vim.api.nvim_buf_del_extmark(buf, ns, mark[1])
	end
end

local function highlight_range(from, to, group)
	for i = from, to do
		vim.api.nvim_buf_set_extmark(buf, ns, i, 0, {
			hl_eol = true,
			line_hl_group = group,
		})
	end
end

local function highlight_cells()
	clear_all()

	local query = ts.query.parse(parsername, tsquery)
	local tree = parser:parse()
	local root = tree[1]:root()
	for _, match, _ in query:iter_matches(root, buf, 0, -1, { all = true }) do
		for _, nodes in pairs(match) do
			for _, node in ipairs(nodes) do
				local start_line, _, end_line, _ = node:range()
				pcall(highlight_range, start_line, start_line, '@markup.codecell.lang')
				pcall(highlight_range, start_line + 1, end_line - 2, '@markup.codecell')
				pcall(highlight_range, end_line - 1, end_line - 1, '@markup.codecell.end')
			end
		end
	end
end

highlight_cells()

vim.api.nvim_create_autocmd({ 'ModeChanged', 'BufWrite' }, {
	group = vim.api.nvim_create_augroup('QuartoCellHighlight', { clear = true }),
	buffer = buf,
	callback = highlight_cells,
})
