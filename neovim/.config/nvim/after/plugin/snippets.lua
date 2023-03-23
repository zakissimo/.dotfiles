local ls = require("luasnip")

local snip = ls.snippet
local text = ls.text_node
local func = ls.function_node
local insert = ls.insert_node
-- local node = ls.snippet_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node

local ifn = function()
    local filename = vim.fn.expand("%:t:r") .. "_H"
    return { "#ifndef " .. filename, "# define " .. filename }
end

ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = "ifn",
            name = "ifndef",
            dscr = "Include Guard Lines",
        }, {
            func(ifn, {}),
            text(" "),
            insert(1),
            text("#endif"),
        }),
    },
})
