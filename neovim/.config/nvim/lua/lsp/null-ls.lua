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
		formatting.autopep8,
		formatting.prettierd.with({ filetypes = { "css" } }),
		formatting.deno_fmt.with({ extra_args = { "--options-single-quote" } }),
		diagnostics.shellcheck,
		diagnostics.pylint.with({
			extra_args = { "--disable=C0111" },
		}),
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
