local set = vim.opt

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
