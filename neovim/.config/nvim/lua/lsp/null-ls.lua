local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
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

	on_attach = require("lsp.handlers").on_attach,
	capabilities = require("lsp.handlers").capabilities,
})
