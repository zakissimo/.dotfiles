local M = {}

M.setup = {
    input_map = "<Leader>mm"
}

M.code = function ()
    local prompt = "Insert Command: "
    local bufmap = vim.api.nvim_buf_set_keymap
    vim.ui.input({ prompt = prompt }, function(input)
        if input then
            bufmap(0, "n", M.setup.input_map,
                ":w<CR>:!" .. input .. "<CR>", { noremap = true })
        end
    end)
end

return M
