return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'kyazdani42/nvim-tree.lua'
	use 'norcalli/nvim-colorizer.lua'
	use 'kyazdani42/nvim-web-devicons'
	use "lukas-reineke/indent-blankline.nvim"
	use { "catppuccin/nvim", as = "catppuccin" }
	use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
	use 'rcarriga/nvim-notify'

	use 'junegunn/fzf.vim'
	use { 'junegunn/fzf', run = ':call fzf#install()' }
	use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	use 'windwp/nvim-autopairs'
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use 'onsails/lspkind-nvim'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'neovim/nvim-lspconfig'
	use 'saadparwaiz1/cmp_luasnip'
	use 'williamboman/nvim-lsp-installer'
	use 'nvim-treesitter/nvim-treesitter-refactor'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use ({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})

	use 'romgrk/barbar.nvim'
	use 'nvim-lualine/lualine.nvim'
end)
