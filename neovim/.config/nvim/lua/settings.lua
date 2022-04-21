local set = vim.opt

vim.notify = require("notify")
vim.g.python3_host_prog = "/usr/bin/python"

-- set.foldenable = false
set.autochdir = true
set.clipboard = "unnamedplus"
set.cursorline = true
set.fileencoding = "utf-8"
set.ignorecase = true
set.mouse = "a"
set.number = true
set.relativenumber = true
set.scrolloff = 5
set.shiftwidth = 4
set.smartcase = true
set.splitbelow = true
set.splitright = true
set.swapfile = false
set.tabstop = 4
set.updatetime = 1000
set.wrap = true

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

set.laststatus = 3
