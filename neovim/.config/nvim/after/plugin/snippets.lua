local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
-- local node = ls.snippet_node
-- local text = ls.text_node
-- local insert = ls.insert_node
local func = ls.function_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node

local date = function()
    return { "--Filename basename is: " .. vim.fn.expand("%:t:r") }
end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "testus",
            namr = "testus",
            dscr = "testus lol",
        }, {
            func(date, {}),
        }),
    },
})
