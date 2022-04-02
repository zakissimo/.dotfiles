local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

require("nvim-dap-virtual-text").setup({
	enabled = true, -- enable this plugin (the default)
	enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
	highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
	highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
	show_stop_reason = true, -- show stop reason when stopped for exceptions
	commented = false, -- prefix virtual text with comment string
	-- experimental features:
	virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
	all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
	virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
	virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
	-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

vim.g.mapleader = " "
require("dap-python").setup("/usr/bin/python")

map("n", "<leader>db", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
map("n", "<leader>dn", '<cmd>lua require"dap".continue()<CR>', opts)
map("n", "<leader>dv", '<cmd>lua require"dap".step_over()<CR>', opts)
map("n", "<leader>di", '<cmd>lua require"dap".step_into()<CR>', opts)
map("n", "<leader>do", '<cmd>lua require"dap".step_out()<CR>', opts)

map("n", "<leader>dsc", '<cmd>lua require"dap.ui.variables".scopes()<CR>', opts)
map("n", "<leader>dhh", '<cmd>lua require"dap.ui.variables".hover()<CR>', opts)
map("v", "<leader>dhv", '<cmd>lua require"dap.ui.variables".visual_hover()<CR>', opts)

map("n", "<leader>duh", '<cmd>lua require"dap.ui.widgets".hover()<CR>', opts)
map(
	"n",
	"<leader>duf",
	"<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
	opts
)

map("n", "<leader>dsbr", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
map(
	"n",
	"<leader>dsbm",
	'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	opts
)
map("n", "<leader>dro", '<cmd>lua require"dap".repl.open()<CR>', opts)
map("n", "<leader>drl", '<cmd>lua require"dap".repl.run_last()<CR>', opts)
