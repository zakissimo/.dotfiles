local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

catppuccin.setup()

local colors = require("catppuccin.api.colors").get_colors()

catppuccin.remap({
	Comment = { fg = colors.overlay1 },
	LineNr = { fg = colors.overlay1 },
	CursorLineNr = { fg = colors.sky },
	DiagnosticError = { bg = colors.none },
	DiagnosticInfo = { bg = colors.none },
	DiagnosticHint = { bg = colors.none },
	DiagnosticWarn = { bg = colors.none },
})

vim.cmd([[colorscheme catppuccin]])
