local set = vim.opt
local opt = { noremap = true }
local bufmap = vim.api.nvim_buf_set_keymap

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = vim.api.nvim_create_augroup("TabSpace", { clear = true }),
	callback = function()
		local ft = vim.bo.filetype
		if ft == "css" or ft == "html" then
			set.tabstop = 2
			set.shiftwidth = 2
			set.expandtab = true
		else
			set.tabstop = 4
			set.shiftwidth = 4
		end
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = vim.api.nvim_create_augroup("YankHl", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = vim.api.nvim_create_augroup("TermOpen", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
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
	end,
})