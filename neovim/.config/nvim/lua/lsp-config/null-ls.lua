local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.formatting.eslint,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.autopep8,
	null_ls.builtins.diagnostics.shellcheck,
	null_ls.builtins.formatting.clang_format,
	null_ls.builtins.formatting.markdownlint,
	null_ls.builtins.diagnostics.markdownlint,
	null_ls.builtins.diagnostics.pylint.with({
		extra_args = { "--disable=C" },
	}),
}

null_ls.setup({
	sources = sources,

	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
