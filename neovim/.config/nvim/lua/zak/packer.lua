local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end,
    })
    use({ "nvim-lua/plenary.nvim" })

    use({ "zakissimo/run.nvim" })
    use({ "zakissimo/term.nvim" })
    use({ "zakissimo/hook.nvim" })

    use({ "stevearc/dressing.nvim" })
    use({
        "ibhagwan/fzf-lua",
        requires = { "kyazdani42/nvim-web-devicons" },
    })

    use("folke/tokyonight.nvim")
    use({ "rose-pine/neovim", as = "rose-pine" })
    use("nvim-lualine/lualine.nvim")

    use("mbbill/undotree")
    use("kyazdani42/nvim-tree.lua")

    use("lewis6991/gitsigns.nvim")
    use("kdheepak/lazygit.nvim")

    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    })
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    })
    use({ "rcarriga/nvim-notify" })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })
    use({ "norcalli/nvim-colorizer.lua" })

    use("MunifTanjim/nui.nvim")
    use("dpayne/CodeGPT.nvim")
    use({
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
        config = function()
            require("zak.copilot")
        end,
    })
    use({
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            "jose-elias-alvarez/null-ls.nvim",
            "jay-babu/mason-null-ls.nvim",
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional
            { "onsails/lspkind-nvim" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    })
    use("42Paris/42header")

    if packer_bootstrap then
        require("packer").sync()
    end
end)
