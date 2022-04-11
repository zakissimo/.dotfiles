local fn = vim.fn

-- Automatically install packer
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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("kyazdani42/nvim-tree.lua")

	use("lukas-reineke/indent-blankline.nvim")

	use("norcalli/nvim-colorizer.lua")
	use("kyazdani42/nvim-web-devicons")
	use({ "ellisonleao/gruvbox.nvim" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "AlphaTechnolog/pywal.nvim", as = "pywal" })

	use("rcarriga/nvim-notify")

	use({
		"ibhagwan/fzf-lua",
		-- optional for icon support
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use("junegunn/fzf.vim")
	use({ "junegunn/fzf", run = ":call fzf#install()" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "ThePrimeagen/harpoon" })

	use("windwp/nvim-autopairs")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use("junegunn/vader.vim")

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
	use("williamboman/nvim-lsp-installer")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- use({ "neoclide/coc.nvim", branch = "release" })

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
	use("theHamsta/nvim-dap-virtual-text")
	use("mfussenegger/nvim-dap-python")

	use("akinsho/toggleterm.nvim")

	use("nvim-lualine/lualine.nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
