local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local path, buf
local function bottom_term_init()
    path = vim.fn.expand("%:p:h")
    buf = vim.api.nvim_create_buf({}, {})
    vim.cmd("13sp")
    vim.cmd("buffer" .. buf)
    _ = vim.fn.termopen("zsh")
    vim.cmd("startinsert")
    return path, buf
end

local term_path, term_bufnr
function _BOTTOM_TERM_TOGGLE()
    path = vim.fn.expand("%:p:h")
    if vim.fn.bufexists(term_bufnr) ~= 0 then
        if vim.fn.bufwinnr(term_bufnr) > -1 then
            vim.api.nvim_win_close(vim.fn.win_getid(vim.fn.bufwinnr(term_bufnr)), "force")
        else
            if term_path ~= path then
                vim.cmd(term_bufnr .. "bd!")
                term_path, term_bufnr = bottom_term_init()
            else
                vim.cmd("13sp")
                vim.cmd("buffer" .. term_bufnr)
                vim.cmd("startinsert")
            end
        end
    else
        term_path, term_bufnr = bottom_term_init()
    end
end

map("n", "<leader>tt", ":lua _BOTTOM_TERM_TOGGLE()<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n>:lua _BOTTOM_TERM_TOGGLE()<CR>", opts)
