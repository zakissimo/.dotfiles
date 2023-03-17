require("nvim-tree").setup({
    diagnostics = {
        enable = true,
    },
    disable_netrw = false,
    hijack_netrw = false,
    view = {
        number = false,
        relativenumber = false,
        centralize_selection = true,
    },
    sync_root_with_cwd = false,
    respect_buf_cwd = false,
    update_cwd = false,
    update_focused_file = {
        enable = false,
        update_cwd = false,
    },
})
