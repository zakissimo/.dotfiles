vim.cmd("colorscheme rose-pine")
--vim.cmd('colorscheme tokyonight')
vim.notify = require("notify").setup({
    background_colour = "#000000",
})

vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end
end

local set = vim.opt
set.termguicolors = true
require("colorizer").setup()
