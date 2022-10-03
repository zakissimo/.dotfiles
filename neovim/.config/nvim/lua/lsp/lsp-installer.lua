local lspconfig = require("lspconfig")
local lsp_installer = require("mason-lspconfig")
local servers = lsp_installer.get_installed_servers()

local server_table = {}
local init_table = {
	"tailwindcss",
	"tsserver",
	"gopls",
	"pyright",
	"rust_analyzer",
	"sumneko_lua",
	"clangd",
	"html",
}

for idx in pairs(init_table) do
	table.insert(server_table, init_table[idx])
end
for idx in pairs(servers) do
	local server = servers[idx].name
	table.insert(server_table, server)
end

-- Debugging lines
-- vim.pretty_print(server_table)


lsp_installer.setup()

for _, server in pairs(server_table) do
	local opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}
	if server == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	elseif server == "tsserver" then
		local ts_opts = { init_options = require("nvim-lsp-ts-utils").init_options }
		opts = vim.tbl_deep_extend("force", ts_opts, opts)
	-- elseif server == "clangd" then
	-- 	opts.cmd = {"clangd", "--background-index", "--cross-file-rename", "--compile-commands-dir=/home/zak"}
	end
	lspconfig[server].setup(opts)
end
