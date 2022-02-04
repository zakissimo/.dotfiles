require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
	  'python',
	  'lua',
	  'bash',
	  'c',
	  'cmake',
	  'comment',
	  'json',
	  'make',
	  'vim'
  },

  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = { enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
	navigation = { enable = true,
		  keymaps = {
			goto_definition = "gnd",
			list_definitions = "gnD",
			list_definitions_toc = "gO",
			goto_next_usage = "<A-)>",
			goto_previous_usage = "<A-=>",
		  },
		},
  	},
}
