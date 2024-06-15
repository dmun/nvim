return {
	"MeanderingProgrammer/markdown.nvim",
	enabled = false,
	dependencies = "nvim-treesitter/nvim-treesitter",
	opts = {
		headings = { "◆ ", "◇ " },
		bullets = { "•" },
		markdown_query = [[
			(atx_heading [
				(atx_h1_marker)
				(atx_h2_marker)
				(atx_h3_marker)
				(atx_h4_marker)
				(atx_h5_marker)
				(atx_h6_marker)
			] @heading)

			(thematic_break) @dash

			(fenced_code_block) @code

			(block_quote (block_quote_marker) @quote_marker)
			(block_quote (paragraph (inline (block_continuation) @quote_marker)))

			(pipe_table) @table
			(pipe_table_header) @table_head
			(pipe_table_delimiter_row) @table_delim
			(pipe_table_row) @table_row
		]],
		win_options = {
			conceallevel = {
				rendered = 2,
			},
			concealcursor = {
				rendered = "",
			},
		},
		highlights = {
			heading = {
				backgrounds = { "Heading1" },
			},
		},
	},
	config = function(_, opts)
		vim.cmd("hi Heading1 guifg=white guibg=#1E272B gui=bold")
		require("render-markdown").setup(opts)
	end,
}
