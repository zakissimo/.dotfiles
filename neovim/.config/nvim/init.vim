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
	
	syntax enable                           " Enables syntax highlighing

	set hidden                              " Required to keep multiple buffers open multiple buffers
	set encoding=utf-8                      " The encoding displayed
	set fileencoding=utf-8                  " The encoding written to file
	set pumheight=10                        " Makes popup menu smaller
	set cmdheight=1                         " More space for displaying messages
	set iskeyword+=-                      	" treat dash separated words as a word text object"
	set mouse=a                             " Enable your mouse
	set splitbelow                          " Horizontal splits will automatically be below
	set splitright                          " Vertical splits will automatically be to the right
	set number relativenumber
	set hlsearch
	set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set expandtab                           " Converts tabs to spaces
	set smartindent                         " Makes indenting smart
	set autoindent                          " Good auto indent
	set updatetime=300                      " Faster completion
	set timeoutlen=500                      " By default timeoutlen is 1000 ms
	set autochdir                           " Your working directory will always be the same as your worki
        
	let g:airline_theme='minimalist'

    " Code runner
	map <leader>n :w<CR>:!python3 %<CR>
	map <leader>b :w<CR>:!bash %<CR>

    " EZ Substitute
	nnoremap S :%s///g<Left><Left><Left>
	nnoremap s :s///g<Left><Left><Left>

    " EZ window navigation 
	map <C-j> <C-W>j
	map <C-k> <C-W>k
	map <C-h> <C-W>h
	map <C-l> <C-W>l

    " Use alt + hjkl to resize windows
    nnoremap <M-j>    :resize -2<CR>
    nnoremap <M-k>    :resize +2<CR>
    nnoremap <M-h>    :vertical resize -2<CR>
    nnoremap <M-l>    :vertical resize +2<CR>

    " Better tabbing
    vnoremap < <gv
    vnoremap > >gv

    " TAB in general mode will move to text buffer
    nnoremap <TAB> :bnext<CR>
    " SHIFT-TAB will go back
    nnoremap <S-TAB> :bprevious<CR>

    " Alternate way to save
    nnoremap <C-s> :w<CR>
    " Alternate way to quit
    nnoremap <C-Q> :wq!<CR>
    " <TAB>: completion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


	hi LineNr ctermfg=DarkGray
	hi Visual ctermfg=Black
	hi Visual ctermbg=DarkGray
	hi Search ctermbg=LightYellow

endif      
