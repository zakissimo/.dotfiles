-- local cmd = vim.cmd

require'lualine'.setup({
    options = {
		theme = 'catppuccin',
        section_separators = { left = '', right = ''},
        component_separators = '',
    },
})

-- cmd[[hi NvimTreeStatusLineNC guibg=nvim_treebg guifg=nvim_treebg]]
-- cmd[[au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" || bufname('%') == "packer" | set laststatus=0 | else | set laststatus=2 | endif]]
