local set = vim.opt

-- vim.notify = require("notify")
vim.g.python3_host_prog = "/usr/bin/python"

-- set.foldenable = false
set.autochdir = true
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
set.updatetime = 1000
set.expandtab = true
set.wrap = true

vim.cmd("set fillchars+=eob:│")

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = vim.api.nvim_create_augroup("TabSpace", { clear = true }),
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
	group = vim.api.nvim_create_augroup("YankHl", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

set.laststatus = 3

require("harpoon").setup({
	global_settings = {
		-- set marks specific to each git branch inside git repository
		save_on_toggle = true,
		mark_branch = true,
	},
})

require("nvim-navic").setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "練",
		Interface = "練",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = false,
	separator = " > ",
	depth_limit = 0,
	depth_limit_indicator = "..",
})

vim.api.nvim_create_autocmd(
	{ "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
	{
		group = vim.api.nvim_create_augroup("RefreshWinBar", { clear = true }),
		callback = function()
			require("winbar").get_winbar()
		end,
	}
)
