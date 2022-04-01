local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

local opt = { noremap = true }
local map = vim.api.nvim_set_keymap
-- local opts = { noremap = true, silent = true }

toggleterm.setup({
	size = 20,
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
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

-- map("t", "<esc>", "<C-\\><C-N>", opts)
map("n", "<Leader>gg", ":lua _LAZYGIT_TOGGLE()<CR>", opt)
