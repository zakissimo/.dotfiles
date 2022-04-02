vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#6E6C7E gui=nocombine]]

require("indent_blankline").setup({
	char = "│",
	-- char_highlight_list = {
	--     "IndentBlanklineIndent1",
	-- },
	-- space_char_highlight_list = {
	--     "IndentBlanklineIndent1",
	-- },
	show_trailing_blankline_indent = false,
})
