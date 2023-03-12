require("fzf-lua").setup({

    winopts = {
        hl = {
            border = "FloatBorder",
        },
    },
    files = {
        cmd = "rg --files --hidden -g '!{**/node_modules/*,**/.git/*}' 2> /dev/null",
    },
    previewers = {
        builtin = {
            extensions = {
                -- neovim terminal only supports `viu` block output
                ["png"] = { "ueberzug" },
                ["jpg"] = { "ueberzug" },
                ["jpeg"] = { "ueberzug" },
            },
            -- When using 'ueberzug' we can also control the way images
            -- fill the preview area with ueberzug's image scaler, set to:
            --   false (no scaling), "crop", "distort", "fit_contain",
            --   "contain", "forced_cover", "cover"
            -- For more details see:
            -- https://github.com/seebye/ueberzug
            ueberzug_scaler = "fit_contain",
        },
    },
})
