local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("n", "<esc><esc>", ":noh<CR>", opts)
map("n", "<C-s>", ":w<CR>", opts)
map("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("x", "<leader>p", '"_dP', opts)

map("n", "<leader>x", ":!chmod +x %<CR>", opts)
map("n", "<leader>pr", ":PackerSync<CR>", opts)
map("n", "<leader>lr", ":w!<CR>:luafile %<CR>", opts)

map("n", "S", ":%s///g<Left><Left><Left>", { noremap = true })
map("v", "S", ":s///g<Left><Left><Left>", { noremap = true })

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

map("n", "<M-,>", ":bprevious<CR>", opts)
map("n", "<M-.>", ":bnext<CR>", opts)
map("n", "<M-;>", ":tabprevious<CR>", opts)
map("n", "<M-'>", ":tabnext<CR>", opts)

map("n", "<Leader>uu", ":UndotreeToggle<CR>", opts)
map("n", "<Leader>gg", ":LazyGit<CR>", opts)

map("n", "<Leader>fb", ":FzfLua buffers<CR>", opts)
map("n", "<Leader>fr", ":FzfLua registers<CR>", opts)
map("n", "<Leader>ft", ":FzfLua tabs<CR>", opts)
map("n", "<Leader>fl", ":FzfLua live_grep<CR>", opts)
map("n", "<Leader>o", ":lua require'fzf-lua'.files({ cwd='~' })<CR>", opts)
map("n", "<Leader>ff", ":FzfLua git_files<CR>", opts)
