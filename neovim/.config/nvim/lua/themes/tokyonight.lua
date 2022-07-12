vim.g.tokonight_style = "storm"
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

-- vim.cmd([[
--     hi DiagnosticError guibg=NONE
--     hi DiagnosticInfo guibg=NONE
--     hi DiagnosticHint guibg=NONE
--     hi DiagnosticWarn guibg=NONE
-- ]])

-- local colors = require("catppuccin.api.colors").get_colors()
--
-- vim.g.tokyonight_colors = {
-- 	Comment = colors.overlay1,
-- 	LineNr = colors.overlay1,
-- 	CursorLineNr = colors.sky,
-- 	DiagnosticInfo = colors.none,
-- 	DiagnosticError = colors.none,
-- 	DiagnosticHint = colors.none,
-- 	DiagnosticWarn = colors.none,
-- }

vim.cmd([[colorscheme tokyonight]])
