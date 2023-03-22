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
    local buflist = vim.api.nvim_list_bufs()
    local active_bufs = {}

    for _, v in ipairs(buflist) do
        if vim.api.nvim_buf_is_loaded(v)
            and vim.api.nvim_buf_get_option(v, "buftype")
                ~= "nofile" then
            table.insert(active_bufs, v)
        end
    end

    return active_bufs
end

local get_bufs_names = function(active_bufs)
    local buf_tab = {}

    for _, v in ipairs(active_bufs) do
        local full_fname = vim.fn.getbufinfo(v)[1].name
        local fname = vim.fn.fnamemodify(full_fname, ':t')
        local bufnr = vim.fn.getbufinfo(v)[1].bufnr
        if fname ~= "" then
            buf_tab[fname] = bufnr
        end
    end
    return buf_tab
end

local set_bufs_names = function(bufs)
    local bufnames = {}
    for b, _ in pairs(bufs) do
        table.insert(bufnames, b)
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, bufnames)
end

local open_hook_win = function ()
    set_bufs_names(get_bufs_names(get_active_bufs()))
    vim.api.nvim_open_win(buf, true, config)
end

local get_lines_from_win = function ()
    if vim.fn.bufwinnr(buf) > -1 then
        vim.api.nvim_create_autocmd({ "BufLeave" }, {
            pattern = "hook",
            group = vim.api.nvim_create_augroup("hook", { clear = true }),
            callback = function ()
               vim.print(vim.api.nvim_buf_get_lines(buf, 0, -1, false))
            end
        })
    end
end
