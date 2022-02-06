local lsp_installer = require("nvim-lsp-installer")

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.buf.open_float()<CR>", opts)
	buf_set_keymap("n", "dH", "<cmd>lua vim.lsp.buf.goto_prev()<CR>", opts)
	buf_set_keymap("n", "dL", "<cmd>lua vim.lsp.buf.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.buf.setloclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- local servers = { "pyright", "bashls", "clangd", "cmake", "jsonls", "eslint", "sumneko_lua" }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- for _, name in pairs(servers) do
-- 	local server_is_found, server = lsp_installer.get_server(name)
-- 	if server_is_found then
-- 		if not server:is_installed() then
-- 			print("Installing " .. name)
-- 			server:install()
-- 		end
-- 	end
-- end

lsp_installer.on_server_ready(function(server)
	-- Specify the default options which we'll use to setup all servers
	local default_opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		default_opts = vim.tbl_deep_extend("force", sumneko_opts, default_opts)
	end

	server:setup(default_opts)
end)
