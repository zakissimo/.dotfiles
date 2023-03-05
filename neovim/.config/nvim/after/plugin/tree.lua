require("nvim-tree").setup({
    diagnostics = {
        enable = true,
    },
    disable_netrw = false,
    hijack_netrw = true,
    view = {
        number = false,
        relativenumber = false,
        centralize_selection = true,
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
})
