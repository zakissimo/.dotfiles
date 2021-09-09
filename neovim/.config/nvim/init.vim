"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
            "██╗███╗   ██╗██╗████████╗
            "██║████╗  ██║██║╚══██╔══╝
            "██║██╔██╗ ██║██║   ██║   
            "██║██║╚██╗██║██║   ██║   
            "██║██║ ╚████║██║   ██║   
            "╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   
            
set clipboard+=unnamedplus
	
let mapleader =" "

if exists('g:vscode')
	" VSCode extension
	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine
	nnoremap s :s,,,g
	nnoremap S :%s,,,g

else
	" ordinary neovim
	call plug#begin('~/.config/nvim/plugged')

	Plug 'vim-airline/vim-airline'
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-compe'
	Plug 'vim-airline/vim-airline-themes'

	call plug#end()
	
	let g:airline_theme='minimalist'

	map <C-j> <C-W>j
	map <C-k> <C-W>k
	map <C-h> <C-W>h
	map <C-l> <C-W>l
	map <leader>n :w<CR>:!python3 %<CR>
	nnoremap S :%s///g<Left><Left><Left>
	nnoremap s :s///g<Left><Left><Left>

	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set number relativenumber
	set hlsearch

	hi LineNr ctermfg=DarkGray
	hi Visual ctermfg=Black
	hi Visual ctermbg=DarkGray
	hi Search ctermbg=LightYellow
	hi Search ctermfg=Red

endif      
