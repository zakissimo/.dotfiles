return {
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim", "describe", "it" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
