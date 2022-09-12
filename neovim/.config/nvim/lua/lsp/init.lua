local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("lsp.handlers").setup()
require("lsp.nvim-cmp")
require("lsp.snippets.c")
require("lsp.lsp-installer")
require("lsp.null-ls")
-- require("norme").setup()
-- require("lsp.handlers").toggle_format_on_save()
