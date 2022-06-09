local set = vim.opt

-- vim.notify = require("notify")
vim.g.python3_host_prog = "/usr/bin/python"

-- set.foldenable = false
set.autochdir = false
set.clipboard = "unnamedplus"
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
set.updatetime = 1000
set.expandtab = true
set.wrap = true

vim.cmd("set fillchars+=eob:│")

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		local ft = vim.bo.filetype
		if ft == "css" or ft == "html" then
			set.tabstop = 2
			set.shiftwidth = 2
		else
			set.shiftwidth = 4
			set.tabstop = 4
		end
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

set.laststatus = 3

vim.cmd([[
    hi DiagnosticError guibg=NONE
    hi DiagnosticInfo guibg=NONE
    hi DiagnosticHint guibg=NONE
    hi DiagnosticWarn guibg=NONE
]])

require("harpoon").setup({
	global_settings = {
		-- set marks specific to each git branch inside git repository
        save_on_toggle = true,
		mark_branch = true,
	},
})
