local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_name(buf, "hook")
local w = 21
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
        if vim.api.nvim_buf_is_loaded(v)
            and vim.api.nvim_buf_get_option(v, "buftype")
                ~= "nofile" then
            local full_fname = vim.fn.getbufinfo(v)[1].name
            local fname = vim.fn.fnamemodify(full_fname, ':t')
            if fname ~= "" then
                btab[fname] = v
            end
        end
    end
    return btab
end

local get_bufs_names = function(btab)
    local bnames = {}
    for bname, _ in pairs(btab) do
        table.insert(bnames, bname)
    end
    return bnames
end

local str_not_in_arr = function(str, arr)
    for _, s in pairs(arr) do
        if s == str then
            return false
        end
    end
    return true
end

local set_inames = function(btab, inames)
    local bnames = get_bufs_names(btab)
    --Add new buffers to interface
    for _, bname in pairs(bnames) do
        if str_not_in_arr(bname, inames) then
            table.insert(inames, bname)
        end
    end
    --Remove garbage input from interface
    for i, iname in pairs(inames) do
        if str_not_in_arr(iname, bnames) then
            table.remove(inames, i)
        end
    end
    return inames
end

local close_buffers = function(btab, inames)
    local bnames = get_bufs_names(btab)
    for _, bname in pairs(bnames) do
        if str_not_in_arr(bname, inames) then
            vim.cmd("bd " .. btab[bname])
        end
    end
end

local btab = {}
local inames = {}
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = vim.api.nvim_create_augroup("Hook", { clear = true }),
    callback = function()
        btab = get_active_bufs()
        inames = set_inames(btab, inames)
    end,
})

local add_prefix = function (inames)
    local t = {}
    for _, n in pairs(inames) do
        table.insert(t, "> " .. n)
    end
    return t
end

local del_prefix = function (inames)
    local t = {}
    for _, n in pairs(inames) do
        table.insert(t, string.sub(n, 3, -1))
    end
    return t
end

_Get_lines_from_win = function ()
    if vim.fn.bufwinnr(buf) > -1 then
        vim.api.nvim_win_close(vim.fn.win_getid(vim.fn.bufwinnr(buf)), "force")
        inames = del_prefix(vim.api.nvim_buf_get_lines(buf, 0, -1, false))
        close_buffers(btab, inames)
    else
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, add_prefix(inames))
        vim.api.nvim_open_win(buf, true, config)
    end
end

Go_to = function(idx)
    local bufnr = btab[inames[idx]]
    if bufnr then
        vim.cmd("b " .. bufnr)
    end
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<C-b>", ":lua _Get_lines_from_win()<CR>", opts)
map("n", "<M-7>", ":lua Go_to(1)<CR>", opts)
map("n", "<M-8>", ":lua Go_to(2)<CR>", opts)
map("n", "<M-9>", ":lua Go_to(3)<CR>", opts)
map("n", "<M-0>", ":lua Go_to(4)<CR>", opts)
