require("fzf-lua").setup({

	files = {
		cmd = "fd --type f --hidden --exclude .git",
	},
	previewers = {
		builtin = {
			extensions = {
				-- neovim terminal only supports `viu` block output
				["png"] = { "viu", "-b" },
				["jpg"] = { "ueberzug" },
			},
			-- When using 'ueberzug' we can also control the way images
			-- fill the preview area with ueberzug's image scaler, set to:
			--   false (no scaling), "crop", "distort", "fit_contain",
			--   "contain", "forced_cover", "cover"
			-- For more details see:
			-- https://github.com/seebye/ueberzug
			ueberzug_scaler = "cover",
		},
	},
})
