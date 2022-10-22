local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("lewis6991/impatient.nvim")

	use("42Paris/42header")
	use("cacharle/c_formatter_42.vim")
	use({ "vinicius507/norme.nvim" })
	use("WhoIsSethDaniel/toggle-lsp-diagnostics.nvim")

	use("kyazdani42/nvim-tree.lua")

	use({ "SmiteshP/nvim-gps" })
	use({ "SmiteshP/nvim-navic" })
	use({
		"utilyre/barbecue.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"smiteshp/nvim-navic",
			"kyazdani42/nvim-web-devicons", -- optional
		},
	})

	use("lukas-reineke/indent-blankline.nvim")

	use("norcalli/nvim-colorizer.lua")
	use("kyazdani42/nvim-web-devicons")
	use("mortepau/codicons.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "AlphaTechnolog/pywal.nvim", as = "pywal" })
	use("folke/tokyonight.nvim")

	use("rcarriga/nvim-notify")

	use({
		"ibhagwan/fzf-lua",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use({ "ThePrimeagen/harpoon" })
	use({ "ThePrimeagen/vim-be-good" })

	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	})
	use("windwp/nvim-autopairs")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use("junegunn/vader.vim")
	use("jbyuki/one-small-step-for-vimkind")

	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use({ "themaxmarchuk/tailwindcss-colors.nvim" })

	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	use("onsails/lspkind-nvim")

	use("neovim/nvim-lspconfig")
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/nvim-treesitter-refactor")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	})

	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui" })
	use("Pocco81/dap-buddy.nvim")
	use("mfussenegger/nvim-dap-python")
	use("theHamsta/nvim-dap-virtual-text")
	use("jayp0521/mason-nvim-dap.nvim")

	use("lewis6991/gitsigns.nvim")
	use("kdheepak/lazygit.nvim")

	use("nvim-lualine/lualine.nvim")
	use({
		"alvarosevilla95/luatab.nvim",
		config = function()
			require("luatab").setup({})
		end,
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
