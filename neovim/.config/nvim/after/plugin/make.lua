local map = vim.api.nvim_set_keymap
local bufmap = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

function _MAKE()
	local prompt = "Insert Command: "
	vim.ui.input({ prompt = prompt }, function(input)
		if input then
			bufmap(0, "n", "<Leader>mm", ":w<CR>:!" .. input .. "<CR>", { noremap = true })
		end
	end)
end

map("n", "<Leader>cc", ":lua _MAKE()<CR>", opts)
