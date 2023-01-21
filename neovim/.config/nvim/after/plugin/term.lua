local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local path, buf, term, cd
local function bottom_term_init()
	path = vim.fn.expand("%:p:h")
	buf = vim.api.nvim_create_buf({}, {})
	vim.cmd("13sp")
	vim.cmd("buffer" .. buf)
	term = vim.fn.termopen("zsh")
	cd = "cd " .. path .. "\r"
	vim.api.nvim_chan_send(term, cd)
	vim.api.nvim_chan_send(term, "clear\r")
	vim.cmd("startinsert")
	return path, buf
end

local bottomTermPath, bottomTermBufId
function _BOTTOM_TERM_TOGGLE()
	path = vim.fn.expand("%:p:h")
	if vim.fn.bufexists(bottomTermBufId) ~= 0 then
		if vim.fn.bufwinnr(bottomTermBufId) > -1 then
			vim.api.nvim_win_close(vim.fn.win_getid(vim.fn.bufwinnr(bottomTermBufId)), "force")
		else
			if bottomTermPath ~= path then
				vim.cmd(bottomTermBufId .. "bd!")
				bottomTermPath, bottomTermBufId = bottom_term_init()
			else
				vim.cmd("13sp")
				vim.cmd("buffer" .. bottomTermBufId)
				vim.cmd("startinsert")
			end
		end
	else
		bottomTermPath, bottomTermBufId = bottom_term_init()
	end
end

map("n", "<leader>tt", ":lua _BOTTOM_TERM_TOGGLE()<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n>:lua _BOTTOM_TERM_TOGGLE()<CR>", opts)
