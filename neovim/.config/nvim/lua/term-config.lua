local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

vim.g.mapleader = " "
local opt = { noremap = true }
local map = vim.api.nvim_set_keymap
local bufmap = vim.api.nvim_buf_set_keymap
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
	bufmap(0, "t", "<C-q>", [[<C-\><C-n>]], opt)
	if vim.fn.win_gettype() ~= "popup" then
		bufmap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opt)
		bufmap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opt)
		bufmap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opt)
		-- bufmap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opt)
		bufmap(0, "t", "<M-j>", [[<C-\><C-n>":resize -2<CR>"]], opt)
		bufmap(0, "t", "<M-k>", [[<C-\><C-n>":resize +2<CR>"]], opt)
		bufmap(0, "t", "<M-h>", [[<C-\><C-n>":vertical resize -2<CR>"]], opt)
		bufmap(0, "t", "<M-l>", [[<C-\><C-n>":vertical resize +2<CR>"]], opt)
	end
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- local Terminal = require("toggleterm.terminal").Terminal

map("n", "<leader>gg", ":TermExec cmd='cd %:p:h;lazygit'<CR>", opts)

-- local lazygit = Terminal:new({
-- 	cmd = "lazygit -p %:p:h",
-- 	insert_mappings = true,
-- 	terminal_mappings = true,
-- })
--
-- function _LAZYGIT_TOGGLE()
-- 	lazygit:toggle()
-- end
-- map("n", "<Leader>gg", ":lua _LAZYGIT_TOGGLE()<CR>", opts)

local jobId
function _BROWSERSYNC_TOGGLE()
	if jobId then
		vim.fn.jobstop(jobId)
		jobId = nil
		vim.notify("BrowserSync server obliterated.")
	else
		jobId = vim.fn.jobstart("browser-sync start --server --files * --no-inject-changes")
		vim.notify("BrowserSync server created.")
	end
end

function _GET_DOCS()
	local filetype = vim.bo.filetype
	local prompt = "Query " .. filetype .. " docs: "
	vim.ui.input({ prompt = prompt }, function(input)
		if input then
			local query = "zeal " .. filetype .. ":" .. input
			vim.fn.jobstart(query)
		end
	end)
end

local function bottom_term_init()
	vim.cmd("13sp term://zsh")
	vim.cmd("startinsert")
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	return vim.fn.getcwd(), vim.api.nvim_get_current_buf()
end

local path
local bottomTermBufId
function _BOTTOM_TERM_TOGGLE()
	local curPath = vim.fn.getcwd()
	if bottomTermBufId then
		if vim.fn.bufwinnr(bottomTermBufId) > -1 then
			vim.cmd("close" .. bottomTermBufId)
		else
			if path ~= curPath then
				vim.cmd(bottomTermBufId .. "bd!")
				path, bottomTermBufId = bottom_term_init()
			else
				vim.cmd("13sp")
				vim.cmd("buffer" .. bottomTermBufId)
				vim.cmd("startinsert")
			end
		end
	else
		path, bottomTermBufId = bottom_term_init()
	end
end

map("n", "<Leader>ss", ":lua _GET_DOCS()<CR>", opts)
map("n", "<Leader>bb", ":lua _BROWSERSYNC_TOGGLE()<CR>", opts)
map("n", "<leader>tt", ":lua _BOTTOM_TERM_TOGGLE()<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n>:lua _BOTTOM_TERM_TOGGLE()<CR>", opts)

-- map("n", "<Leader>rr", "", opts)

-- TODO: For code runner get filetype with vim.bo.filetype
map("n", "<leader>rb", ":w<CR>:!./%<CR>", opts)
-- map("n", "<leader>rp", ":w<CR>:TermExec cmd='python3 %:p' direction=horizontal size=11<CR>", opts)
map("n", "<leader>rp", ":w<CR>:!python3 %<CR>", opts)
map("n", "<leader>rl", ":w<CR>:!lua %<CR>", opts)
map("n", "<leader>rj", ":w<CR>:!node %<CR>", opts)
map("n", "<leader>exj", ":w<CR>:if !isdirectory('node_modules') | !npm install<CR> | endif | !npm test<CR>", opts)
map("n", "<leader>exl", ":w<CR>:!busted<CR>", opts)
map("n", "<leader>exb", ":w<CR>:!BATS_RUN_SKIPPED=true bats %<CR>", opts)
map(
	"n",
	"<leader>wh",
	":w<CR>:if bufwinnr('out.html') > -1 | bd! /tmp/out.html<CR> | endif | !python3 % > /tmp/out.html<CR>:vsplit<CR>:e /tmp/out.html<CR>:w /tmp/out.html<CR>",
	opts
)
map(
	"n",
	"<leader>wj",
	":w<CR>:if bufwinnr('out.json') > -1 | bd out.json<CR> | endif | !python3 % > /tmp/out.json<CR>:vsplit<CR>:e /tmp/out.json<CR>",
	opts
)
