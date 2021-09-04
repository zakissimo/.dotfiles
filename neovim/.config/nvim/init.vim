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

"let mapleader =" "
"" Switch to Fr - mapping
"nnoremap <Leader>f :set noarab<Cr>
"" Switch to Arabic - mapping
"nnoremap <Leader>a :set arab<Cr>

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

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'terryma/vim-multiple-cursors'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	call plug#end()
	
	let g:airline_theme='minimalist'
	nnoremap S :%s///g<Left><Left><Left>
	nnoremap s :s///g<Left><Left><Left>
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4

endif      
