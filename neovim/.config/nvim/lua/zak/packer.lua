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

	use({ "nvim-lua/plenary.nvim" })
	use("kyazdani42/nvim-tree.lua")
	use({
		"ibhagwan/fzf-lua",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	use("folke/tokyonight.nvim")
	use({ "rose-pine/neovim", as = "rose-pine" })
	use("nvim-lualine/lualine.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	use("mbbill/undotree")
	use("lewis6991/gitsigns.nvim")
	use("kdheepak/lazygit.nvim")

	use("42Paris/42header")
	use("cacharle/c_formatter_42.vim")
	use({ "vinicius507/norme.nvim" })

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

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

	if packer_bootstrap then
		require("packer").sync()
	end
end)
