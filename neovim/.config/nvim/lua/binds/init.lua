local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
map("n", "<C-s>", ":w<CR>", opts)
map("n", "<A-w>", ":bd!<CR>", opts)
map("n", "<A-q>", "<C-w>c<CR>", opts)
map("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<C-c>", ":terminal<CR>", opts)
map("t", "<Esc>", "<C-\\><C-N>", opts)

map("n", "<leader>rb", ":w<CR>:!./%<CR>", opts)
map("n", "<leader>rp", ":w<CR>:!python3 %<CR>", opts)
map("n", "<leader>rl", ":w<CR>:!lua %<CR>", opts)
map("n", "<leader>rj", ":w<CR>:!node %<CR>", opts)
map("n", "<leader>ej", ":w<CR>:if !isdirectory('node_modules') | !npm install<CR> | endif | !npm test<CR>", opts)
map("n", "<leader>el", ":w<CR>:!busted<CR>", opts)
map("n", "<leader>eb", ":w<CR>:!BATS_RUN_SKIPPED=true bats %<CR>", opts)
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

map("n", "S", ":%s///g<Left><Left><Left>", { noremap = true })
map("n", "s", ":s///g<Left><Left><Left>", { noremap = true })
map("v", "s", ":s///g<Left><Left><Left>", { noremap = true })

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("n", "<M-j>", ":resize -2<CR>", opts)
map("n", "<M-k>", ":resize +2<CR>", opts)
map("n", "<M-h>", ":vertical resize -2<CR>", opts)
map("n", "<M-l>", ":vertical resize +2<CR>", opts)

map("n", "<A-,>", ":BufferPrevious<CR>", opts)
map("n", "<A-;>", ":BufferNext<CR>", opts)
map("n", "<A-Left>", ":BufferMovePrevious<CR>", opts)
map("n", "<A-Right>", " :BufferMoveNext<CR>", opts)

-- map("n", "<C-p>", ":BufferPick<CR>", opts)
map("n", "<Leader>fb", ":Buffers<CR>", opts)
map("n", "<Leader>fl", ":Rg<CR>", opts)
map("n", "<Leader>o", ":Files ~<CR>", opts)
map("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)
