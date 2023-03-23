local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_name(buf, "hook")
local w = 25
local h = 7

local config = {
    relative = "editor",
    width = w,
    height = h,
    row = (vim.fn.winheight(0) - h) / 2,
    col = (vim.fn.winwidth(0) - w) / 2,
    style = "minimal",
    border = "rounded",
}

local get_active_bufs = function()
    local blist = vim.api.nvim_list_bufs()
    local btab = {}

    for _, v in ipairs(blist) do
        local tmp = {}
        if vim.api.nvim_buf_is_loaded(v)
            and vim.api.nvim_buf_get_option(v, "buftype")
                ~= "nofile" then
            local full_fname = vim.fn.getbufinfo(v)[1].name
            local fname = vim.fn.fnamemodify(full_fname, ':t')
            if fname ~= "" then
                tmp.name = fname
                tmp.bufnr = v
                table.insert(btab, tmp)
            end
        end
    end
    return btab
end

local get_bufs_names = function(btab)
    local bnames = {}
    for _, b in pairs(btab) do
        table.insert(bnames, b.name)
    end
    return bnames
end

local set_bufs_names = function(btab)
    local bnames = get_bufs_names(btab)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, bnames)
end

local str_is_in_table = function(str, table)
    for _, v in ipairs(table) do
        if v == str then
            return true
        end
    end
    return false
end

local get_bufnr_from_name = function (btab, name)
    for _, b in ipairs(btab) do
        if name == b.name then
            return b.bufnr
        end
    end
    return nil
end

local close_removed_buffers = function(btab, inames)
    local bnames = get_bufs_names(btab)
    for _, b in ipairs(bnames) do
        if not str_is_in_table(b, inames) then
            local bufnr = get_bufnr_from_name(btab, b)
            vim.cmd("bd " .. bufnr)
        end
    end
end

local once = true

_Get_lines_from_win = function ()
    local inames = {}

    local btab = get_active_bufs()
    if once then
        set_bufs_names(btab)
        once = false
    end
    if vim.fn.bufwinnr(buf) > -1 then
        vim.api.nvim_win_close(vim.fn.win_getid(vim.fn.bufwinnr(buf)), "force")
    else
        vim.api.nvim_open_win(buf, true, config)
        vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
            pattern = "hook",
            group = vim.api.nvim_create_augroup("hook", { clear = true }),
            callback = function ()
                inames = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                vim.pretty_print(inames)
                close_removed_buffers(btab, inames)
            end
        })
    end
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<C-b>", ":lua _Get_lines_from_win()<CR>", opts)
