local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")
local servers = lsp_installer.get_installed_servers()

local server_table = {}

for idx in pairs(servers) do
	local server = servers[idx].name
	table.insert(server_table, server)
end

-- Debugging lines
table.insert(server_table, "tailwindcss")
table.insert(server_table, "gopls")
table.insert(server_table, "pyright")
table.insert(server_table, "rust_analyzer")
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
		-- elseif server == "clangd" then
		-- 	local clangd_opts = require("lsp.settings.clang")
		-- 	opts = vim.tbl_deep_extend("force", clangd_opts, opts)
	elseif server == "tsserver" then
		local ts_opts = { init_options = require("nvim-lsp-ts-utils").init_options }
		opts = vim.tbl_deep_extend("force", ts_opts, opts)
	end
	lspconfig[server].setup(opts)
end
