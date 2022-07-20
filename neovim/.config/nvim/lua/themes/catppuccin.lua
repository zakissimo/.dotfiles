local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

catppuccin.setup()

local colors = require("catppuccin.palettes").get_palette()
-- catppuccin.remap({
-- 	Comment = { fg = colors.overlay1 },
-- 	LineNr = { fg = colors.overlay1 },
-- 	CursorLineNr = { fg = colors.sky },
-- 	NvimTreeRootFolder = { fg = colors.sky },
-- 	-- DiagnosticInfo = { bg = colors.none },
-- 	-- DiagnosticError = { bg = colors.none },
-- 	-- DiagnosticHint = { bg = colors.none },
-- 	-- DiagnosticWarn = { bg = colors.none },
-- })
--
vim.cmd([[colorscheme catppuccin]])
