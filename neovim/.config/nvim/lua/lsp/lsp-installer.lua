local nvim_lsp_installer = require("nvim-lsp-installer")
local servers = nvim_lsp_installer.get_installed_servers()

local lspconfig = require("lspconfig")

local opts = {
	on_attach = require("lsp.handlers").on_attach,
	capabilities = require("lsp.handlers").capabilities,
}

nvim_lsp_installer.setup({})

for idx in pairs(servers) do
	local server = servers[idx].name

	if server == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	lspconfig[server].setup(opts)
end
