local set = vim.opt

vim.notify = require("notify")
vim.g.python3_host_prog = "/usr/bin/python"

-- set.foldenable = false
set.autochdir = false
-- set.clipboard = "unnamedplus"
set.cursorline = true
set.fileencoding = "utf-8"
set.ignorecase = true
set.mouse = "a"
set.number = true
set.relativenumber = true
set.scrolloff = 5
set.smartcase = true
set.splitbelow = true
set.splitright = true
set.swapfile = false
set.updatetime = 500
set.wrap = true
set.list = true
set.listchars = "tab:>-"

vim.cmd("set fillchars+=eob:│")

set.laststatus = 3

require("notify").setup({
  background_colour = "#000000",
})
