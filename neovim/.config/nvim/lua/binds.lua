local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("n", "<esc><esc>", ":noh<CR>", opts)
map("n", "<C-s>", ":w<CR>", opts)
map("n", "<A-n>", ":tabnew<CR>", opts)
map("n", "<A-w>", ":tabclose<CR>", opts)
map("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("x", "<leader>p", "\"_dP", opts)

map("n", "<leader>x", ":!chmod +x %<CR>", opts)
map("n", "<leader>pr", ":PackerSync<CR>", opts)
map("n", "<leader>lr", ":w!<CR>:luafile %<CR>", opts)

map("n", "S", ":%s///g<Left><Left><Left>", { noremap = true })
map("v", "S", ":s///g<Left><Left><Left>", { noremap = true })

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("n", "<A-j>", ":resize -2<CR>", opts)
map("n", "<A-k>", ":resize +2<CR>", opts)
map("n", "<A-h>", ":vertical resize -2<CR>", opts)
map("n", "<A-l>", ":vertical resize +2<CR>", opts)

map("n", "<A-;>", ":bprevious<CR>", opts)
map("n", "<A-'>", ":bnext<CR>", opts)
map("n", "<A-,>", ":tabprevious<CR>", opts)
map("n", "<A-.>", ":tabnext<CR>", opts)

map("n", "<Leader>gg", ":LazyGit<CR>", opts)

map("n", "<Leader>fb", ":FzfLua buffers<CR>", opts)
map("n", "<Leader>fr", ":FzfLua registers<CR>", opts)
map("n", "<Leader>ft", ":FzfLua tabs<CR>", opts)
map("n", "<Leader>fl", ":FzfLua live_grep<CR>", opts)
map("n", "<Leader>o", ":lua require'fzf-lua'.files({ cwd='~' })<CR>", opts)
map("n", "<Leader>ff", ":FzfLua git_files<CR>", opts)

map("n", "<A-]>", ":lua require('harpoon.mark').add_file()<CR>", opts)
map("n", "<A-[>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
map("n", "<A-y>", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
map("n", "<A-u>", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
map("n", "<A-i>", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
map("n", "<A-o>", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)
map("n", "<A-p>", ":lua require('harpoon.ui').nav_file(5)<CR>", opts)
