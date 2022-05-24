local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.shfmt,
		formatting.stylua,
		formatting.black,
		formatting.prettierd.with({ filetypes = { "css", "html" } }),
		formatting.deno_fmt.with({ extra_args = { "--options-single-quote" } }),
        --"--options-indent-width" 
		-- formatting.clang_format.with({ extra_args = { "-style=WebKit" } }),
		diagnostics.shellcheck,
		diagnostics.pylint.with({
			extra_args = {
				"--disable=C0111",
				"--disable=C0103",
				"--disable=R0903",
				"--disable=R0904",
				"--disable=W0611",
				"--disable=W0612",
				"--disable=W0613",
				"--disable=W0614",
			},
		}),
	},
	-- on_attach = function(client)

	on_attach = require("lsp.handlers").on_attach,
	capabilities = require("lsp.handlers").capabilities,
	-- if client.resolved_capabilities.document_formatting then
	-- 	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	-- end
	-- end,
})
