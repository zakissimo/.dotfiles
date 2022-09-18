vim.g.mapleader = " "
local opt = { noremap = true }
local map = vim.api.nvim_set_keymap
local bufmap = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

function _G.set_terminal_keymaps()
	if vim.fn.win_gettype() ~= "popup" then
		bufmap(0, "t", "<Esc>", [[<C-\><C-n>]], opt)
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

local browserSyncJobId
function _BROWSERSYNC_TOGGLE()
	if browserSyncJobId then
		vim.fn.jobstop(browserSyncJobId)
		browserSyncJobId = nil
		vim.notify("BrowserSync server obliterated.")
	else
		browserSyncJobId = vim.fn.jobstart("browser-sync start --server --files * --no-inject-changes")
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

local path, buf, term, cd
local function bottom_term_init()
	path = vim.fn.expand("%:p:h")
	buf = vim.api.nvim_create_buf({}, {})
	vim.cmd("13sp")
	vim.cmd("buffer" .. buf)
	term = vim.fn.termopen("zsh")
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	cd = "cd " .. path .. "\r"
	vim.api.nvim_chan_send(term, cd)
	vim.api.nvim_chan_send(term, "clear\r")
	vim.cmd("startinsert")
	return path, buf
end

local bottomTermPath, bottomTermBufId
function _BOTTOM_TERM_TOGGLE()
	path = vim.fn.expand("%:p:h")
	if vim.fn.bufexists(bottomTermBufId) ~= 0 then
		if vim.fn.bufwinnr(bottomTermBufId) > -1 then
			vim.api.nvim_win_close(vim.fn.win_getid(vim.fn.bufwinnr(bottomTermBufId)), "force")
		else
			if bottomTermPath ~= path then
				vim.cmd(bottomTermBufId .. "bd!")
				bottomTermPath, bottomTermBufId = bottom_term_init()
			else
				vim.cmd("13sp")
				vim.cmd("buffer" .. bottomTermBufId)
				vim.cmd("startinsert")
			end
		end
	else
		bottomTermPath, bottomTermBufId = bottom_term_init()
	end
end

function _CODE_RUNNER()
	vim.cmd("w!")
	local type = vim.bo.filetype
	if type == "python" then
		vim.cmd("!python3 %:p")
	elseif type == "lua" then
		vim.cmd("!lua %:p")
	elseif type == "javascript" then
		vim.cmd("!node %")
	elseif type == "sh" then
		vim.cmd("!%:p")
	elseif type == "c" then
		vim.cmd("!cc -Wall -Wextra -ggdb -o %:p:r %:p && %:p:r")
	elseif type == "rust" then
		vim.cmd("!rustc % && ./%:t:r")
	elseif type == "typescript" then
		if vim.fn.isdirectory("node_modules") == 0 then
			vim.cmd("!yarn install")
		else
			vim.cmd("!yarn test")
		end
	elseif type == "java" then
		vim.cmd("!javac % && java %:t:r")
	end
end

map("n", "<Leader>ss", ":lua _GET_DOCS()<CR>", opts)
map("n", "<Leader>rr", ":lua _CODE_RUNNER()<CR>", opts)
map("n", "<Leader>bb", ":lua _BROWSERSYNC_TOGGLE()<CR>", opts)
map("n", "<leader>tt", ":lua _BOTTOM_TERM_TOGGLE()<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n>:lua _BOTTOM_TERM_TOGGLE()<CR>", opts)

map("n", "<leader>exl", ":w<CR>:!busted<CR>", opts)
map("n", "<leader>exb", ":w<CR>:!BATS_RUN_SKIPPED=true bats %<CR>", opts)
map("n", "<leader>exj", ":w<CR>:if !isdirectory('node_modules') | !npm install<CR> | endif | !npm test<CR>", opts)
map(
	"n",
	"<leader>wh",
	":w<CR>:if bufwinnr('out.html') > -1 | bd! /tmp/out.html<CR> | endif | !python3 % > /tmp/out.html<CR>:vsplit<CR>:e /tmp/out.html<CR>:w /tmp/out.html<CR>",
	opts
)
-- map(
-- 	"n",
-- 	"<leader>wh",
-- 	":w<CR>:if bufwinnr('out.html') > -1 | bd! /tmp/out.html<CR> | endif | !node % > /tmp/out.html<CR>:vsplit<CR>:e /tmp/out.html<CR>:w /tmp/out.html<CR>",
-- 	opts
-- )
map(
	"n",
	"<leader>wj",
	":w<CR>:if bufwinnr('out.json') > -1 | bd out.json<CR> | endif | !python3 % > /tmp/out.json<CR>:vsplit<CR>:e /tmp/out.json<CR>",
	opts
)
