local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

require("dapui").setup()
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

require("dap").defaults.fallback.terminal_win_cmd = "tabnew"

map("n", "<leader>dd", '<cmd>lua require"dapui".toggle()<CR>', opts)
map("n", "<leader>db", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
map("n", "<leader>dB", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)

map("n", "<leader>dn", '<cmd>lua require"dap".continue()<CR>', opts)
map("n", "<leader>dv", '<cmd>lua require"dap".step_over()<CR>', opts)
map("n", "<leader>di", '<cmd>lua require"dap".step_into()<CR>', opts)
map("n", "<leader>do", '<cmd>lua require"dap".step_out()<CR>', opts)
map("n", "<leader>dq", '<cmd>lua require"dap".close()<CR><cmd>DapVirtualTextForceRefresh<CR>', opts)

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

require("dap-python").setup("/usr/bin/python")

local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = "lldb-vscode", -- adjust as needed
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.expand("%:p:h") .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

		runInTerminal = false,

		-- 💀
		-- If you use `runInTerminal = true` and resize the terminal window,
		-- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
		-- To avoid that uncomment the following option
		-- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
		postRunCommands = { "process handle -p true -s false -n false SIGWINCH" },
		env = function()
			local variables = {}
			for k, v in pairs(vim.fn.environ()) do
				table.insert(variables, string.format("%s=%s", k, v))
			end
			return variables
		end,
	},
}

-- If you want to use this for rust and c, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = {
		vim.fn.stdpath("data") .. "/dapinstall/jsnode/" .. "/vscode-node-debug2/out/src/nodeDebug.js",
	},
}

dap.configurations.javascript = {
	{
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
}
