local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = false,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = false,
    call_servers = "local",
    sign_icons = {
        error = "",
        warn = "",
        hint = "",
        info = "",
    },
})

lsp.configure("sumneko_lua", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gD", function()
        vim.lsp.buf.declaration()
    end, opts)
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "gK", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "gI", function()
        vim.lsp.buf.implementation()
    end, opts)
    vim.keymap.set("n", "<leader>rn", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("n", "gr", function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>q", function()
        vim.diagnostic.setloclist()
    end, opts)
    vim.keymap.set("n", "<leader>el", ":FzfLua lsp_document_diagnostics<CR>", opts)
    vim.keymap.set("n", "<leader>ek", function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>ej", function()
        vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "<leader>k", function()
        vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("n", "gh", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<leader>ca", function()
        vim.lsp.buf.code_action()
    end, opts)
    if client.name ~= "clangd" then
        vim.keymap.set("n", "<F2>", ":lua vim.lsp.buf.format()<CR>", opts)
    end
end)

lsp.nvim_workspace({
    library = vim.api.nvim_get_runtime_file("", true),
})

lsp.setup()

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    }),
    ["<C-k>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<C-j>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<C-l>"] = cmp.mapping(function(fallback)
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        fallback()
    end, { "i", "s" }),
    ["S-Tab>"] = cmp.mapping(function(fallback)
        fallback()
    end, { "i", "s" }),
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
local lspkind = require("lspkind")
local cmp_config = lsp.defaults.cmp_config({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
        col_offset = -3,
        side_padding = 0,
    },
    mapping = cmp_mappings,
    formatting = {
        -- fields = { "kind", "abbr", "menu" },
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
            -- vim_item.abbr = string.sub(vim_item.abbr, 1, 11)
            local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50, symbol_map = { Copilot = "" } })(
                entry,
                vim_item
            )
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = ""
            return kind
        end,
    },
    sources = cmp.config.sources({
        -- { name = "copilot" },
        { name = "nvim_lsp", max_item_count = 5 },
        { name = "luasnip",  max_item_count = 3 },
        { name = "path" },
    }),
})

cmp.setup(cmp_config)

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    on_attach = function(client, bufnr)
        client.offset_encoding = "utf-8"
        null_opts.on_attach(client, bufnr)
        local format_cmd = function(input)
            vim.lsp.buf.format({
                id = client.id,
                timeout_ms = 5000,
                async = input.bang,
            })
        end

        local bufcmd = vim.api.nvim_buf_create_user_command
        bufcmd(bufnr, "NullFormat", format_cmd, {
            bang = true,
            range = true,
            desc = "Format using null-ls",
        })
    end,
    sources = {
        formatting.shfmt.with({ extra_args = { "--indent", "4" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        formatting.autopep8,
        formatting.clang_format.with({ extra_args = { "-style", "{IndentWidth: 4}" } }),
        formatting.prettierd.with({ filetypes = { "css", "html" } }),
        formatting.deno_fmt.with({ extra_args = { "--options-single-quote", "--options-indent-width=4" } }),
        diagnostics.shellcheck,
        diagnostics.pylint.with({
            extra_args = {
                "--disable=C0111",
                "--disable=C0103",
                "--disable=F0401",
                "--disable=R0903",
                "--disable=R0904",
                "--disable=W0231",
                "--disable=W0611",
                "--disable=W0612",
                "--disable=W0613",
                "--disable=W0614",
            },
        }),
        code_actions.eslint,
    },
})

require("mason-null-ls").setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = true,
})

-- Required when `automatic_setup` is true
require("mason-null-ls").setup_handlers({})
