local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

vim.g.mapleader = " "
local opt = { noremap = true }
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

toggleterm.setup({
	size = 20,
	hidden = false,
	open_mapping = [[<C-c>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	vim.api.nvim_buf_set_keymap(0, "t", "<C-q>", [[<C-\><C-n>]], opt)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opt)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opt)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opt)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opt)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit %:p", hidden = false, terminal_mappings = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

-- map("t", "<esc>", "<C-\\><C-N>", opts)
map("n", "<Leader>gg", ":lua _LAZYGIT_TOGGLE()<CR>", opts)
-- map("n", "<Leader>rr", ":ToggleTerm dir=% size=10 direction=horizontal<CR>", opts)

local browsersync = Terminal:new({
	cmd = "browser-sync start --server --files '*' --no-inject-changes",
	hidden = false,
	-- start_in_insert = false,
})

function _BROWSERSYNC_TOGGLE()
	browsersync:toggle()
end

map("n", "<Leader>bb", ":lua _BROWSERSYNC_TOGGLE()<CR>", opts)

map("n", "<leader>rb", ":w<CR>:!./%<CR>", opts)
map("n", "<leader>rp", ":w<CR>:TermExec cmd='python3 %:p' direction=horizontal<CR>", opts)
map("n", "<leader>rl", ":w<CR>:!lua %<CR>", opts)
map("n", "<leader>rj", ":w<CR>:!node %<CR>", opts)
map("n", "<leader>exj", ":w<CR>:if !isdirectory('node_modules') | !npm install<CR> | endif | !npm test<CR>", opts)
map("n", "<leader>exl", ":w<CR>:!busted<CR>", opts)
map("n", "<leader>exb", ":w<CR>:!BATS_RUN_SKIPPED=true bats %<CR>", opts)
map(
	"n",
	"<leader>wh",
	":w<CR>:if bufwinnr('out.html') > -1 | bd out.html<CR> | endif | !python3 % > /tmp/out.html<CR>:vsplit<CR>:e /tmp/out.html<CR>",
	opts
)
map(
	"n",
	"<leader>wj",
	":w<CR>:if bufwinnr('out.json') > -1 | bd out.json<CR> | endif | !python3 % > /tmp/out.json<CR>:vsplit<CR>:e /tmp/out.json<CR>",
	opts
)
