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
	elseif server == "emmet_ls" then
		local emmet_opts = require("lsp.settings.emmet_ls")
		opts = vim.tbl_deep_extend("force", emmet_opts, opts)
	end
	lspconfig[server].setup(opts)
end
