local set = vim.opt

vim.notify = require("notify")

set.tabstop = 4
set.shiftwidth = 4
set.smartcase = true
set.ignorecase = true

set.fileencoding = "utf-8"

set.autochdir = true
set.wrap = true
set.scrolloff = 5
set.splitbelow = true
set.splitright = true
set.foldenable = false
set.relativenumber = true

set.mouse = "a"
set.clipboard = "unnamedplus"

set.swapfile = false
vim.g.python3_host_prog = "/usr/bin/python"
