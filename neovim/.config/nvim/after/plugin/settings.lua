local set = vim.opt

set.autochdir = true
set.cursorline = true
set.fileencoding = "utf-8"
set.ignorecase = true
set.mouse = "a"

set.number = true
set.relativenumber = true

set.scrolloff = 5

set.smartcase = true
set.smartindent = true

set.splitbelow = true
set.splitright = true

set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

set.hlsearch = false
set.incsearch = true

set.timeoutlen = 350
set.ttimeoutlen = 50
set.updatetime = 50
set.wrap = true
set.list = true
set.listchars = "tab:>-,trail:."

vim.cmd("set fillchars+=eob:│")

set.ch = 1
set.ls = 3
