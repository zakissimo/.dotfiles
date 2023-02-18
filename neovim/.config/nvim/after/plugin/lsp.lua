local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.set_preferences({
	suggest_lsp_servers = true,
	setup_servers_on_start = true,
	set_lsp_keymaps = true,
	configure_diagnostics = true,
	cmp_capabilities = true,
	manage_nvim_cmp = true,
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

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-d>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-e>"] = cmp.mapping.close(),
	["<CR>"] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	}),
	["<C-j>"] = cmp.mapping(function(fallback)
		if luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end, { "i", "s" }),
	["<C-k>"] = cmp.mapping(function(fallback)
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
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

local lspkind = require("lspkind")

lsp.setup_nvim_cmp({
	-- sources = cmp.config.sources({
	-- 	{
	-- 		name = "nvim_lsp",
	-- 		entry_filter = function (entry, context)
	-- 			local kind = entry:get_kind()
	--
	-- 			local line = context.cursor_line
	-- 			local col = context.cursor.col
	-- 			if char_before_cursor == "." then
	-- 				if kind == 2 or kind == 5 then
	-- 					return true
	-- 				end
	-- 				return false
	-- 			end
	window = {
		completion = cmp.config.window.bordered()
	},
	mapping = cmp_mappings,
	formatting = {
		-- changing the order of fields so the icon is the first
		fields = { "menu", "abbr", "kind" },
		-- here is where the change happens
		format = function(_, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			return vim_item
		end,
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
		vim.keymap.set("n", "<F2>", ":NullFormat<CR>", opts)
	end
end)

lsp.nvim_workspace({
	library = vim.api.nvim_get_runtime_file("", true),
})

lsp.setup()

-- local cmp_config = lsp.defaults.cmp_config({
-- 	window = {
-- 		completion = cmp.config.window.bordered()
-- 	},
-- 	mapping = cmp_mappings,
-- 	formatting = {
-- 		-- changing the order of fields so the icon is the first
-- 		fields = { "menu", "abbr", "kind" },
-- 		-- here is where the change happens
-- 		format = function(_, vim_item)
-- 			vim_item.kind = lspkind.presets.default[vim_item.kind]
-- 			return vim_item
-- 		end,
-- 	},
-- })
--
-- cmp.setup(cmp_config)

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
		formatting.shfmt,
		formatting.stylua,
		formatting.autopep8,
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

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true, -- You can still set this to `true`
	automatic_setup = true,
})

-- Required when `automatic_setup` is true
require("mason-null-ls").setup_handlers({})
