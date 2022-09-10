local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		formatting.shfmt,
		formatting.stylua,
		formatting.autopep8,
		-- formatting.rustywind,
		formatting.prettierd.with({ filetypes = { "css", "html" } }),
		-- formatting.clang_format.with({ extra_args = { "-style=file:/home/zak/.config/nvim/lua/lsp/settings/42.clang-format" } }),
		formatting.deno_fmt.with({ extra_args = { "--options-single-quote", "--options-indent-width=4" } }),
		-- diagnostics.eslint.with({ prefer_local = "node_modules/.bin" }),
		diagnostics.shellcheck,
		diagnostics.pylint.with({
			extra_args = {
				"--disable=C0111",
				"--disable=C0103",
				"--disable=R0903",
				"--disable=R0904",
				"--disable=W0231",
				"--disable=W0611",
				"--disable=W0612",
				"--disable=W0613",
				"--disable=W0614",
			},
		}),
		code_actions.eslint,
	},

	on_attach = require("lsp.handlers").on_attach,
	capabilities = require("lsp.handlers").capabilities,
})
