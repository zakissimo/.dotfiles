local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("n", "<C-s>", ":w<CR>", opts)
map("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
map("n", "<C-q>", "<C-w>c", opts)

map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<leader>rb", ":w<CR>:!./%<CR>", opts)
map("n", "<leader>rp", ":w<CR>:!python3 %<CR>", opts)
map("n", "<leader>rl", ":w<CR>:!lua %<CR>", opts)
map("n", "<leader>rba", ":w<CR>:!BATS_RUN_SKIPPED=true bats %<CR>", opts)
map("n", "<leader>rh", ":w<CR>:!python3 % > /tmp/a.html<CR>:vsplit<CR>:e /tmp/a.html<CR><CR>", opts)

map("n", "S", ":%s///g<Left><Left><Left>", opts)
map("n", "s", ":s///g<Left><Left><Left>", opts)

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("n", "<M-j>", ":resize -2<CR>", opts)
map("n", "<M-k>", ":resize +2<CR>", opts)
map("n", "<M-h>", ":vertical resize -2<CR>", opts)
map("n", "<M-l>", ":vertical resize +2<CR>", opts)
map("n", "<C-f>", ":Rg<CR>", opts)
map("n", "<C-o>", ":Buffers<CR>", opts)
map("n", "<Leader>o", ":Files<CR>", opts)

map("n", "<A-,>", ":BufferPrevious<CR>", opts)
map("n", "<A-;>", ":BufferNext<CR>", opts)

map("n", "<A-Left>", ":BufferMovePrevious<CR>", opts)
map("n", "<A-Right>", " :BufferMoveNext<CR>", opts)

map("n", "<A-&>", ":BufferGoto 1<CR>", opts)
map("n", "<A-2>", ":BufferGoto 2<CR>", opts)
map("n", '<A-">', ":BufferGoto 3<CR>", opts)
map("n", "<A-'>", ":BufferGoto 4<CR>", opts)
map("n", "<A-(>", ":BufferGoto 5<CR>", opts)
map("n", "<A-->", ":BufferGoto 6<CR>", opts)
map("n", "<A-7>", ":BufferGoto 7<CR>", opts)
map("n", "<A-_>", ":BufferGoto 8<CR>", opts)
map("n", "<A-9>", ":BufferGoto 9<CR>", opts)
map("n", "<A-0>", ":BufferLast<CR>", opts)

map("n", "<A-w>", ":BufferClose<CR>", opts)
map("n", "<C-p>", ":BufferPick<CR>", opts)

map("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)
