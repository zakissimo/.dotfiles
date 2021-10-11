" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|


call plug#begin('~/.config/nvim/plugged')

    Plug 'Raimondi/delimitMate'
    Plug 'ThePrimeagen/vim-be-good'
    Plug 'Yggdroot/indentLine'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'lilydjwg/colorizer'
    Plug 'mg979/vim-visual-multi'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'tpope/vim-commentary'
    Plug 'tweekmonster/startuptime.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-python/python-syntax'

call plug#end()

lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.cssls.setup{}
lua require'lspconfig'.html.setup{}
lua require'lspconfig'.jsonls.setup{}
lua require'lspconfig'.pyright.setup{}

syntax enable                           " Enables syntax highlighing

set autochdir                           " Your working directory will always be the same as your worki
set autoindent                          " Good auto indent
set clipboard=unnamedplus
set cmdheight=1                         " More space for displaying messages
set encoding=utf-8                      " The encoding displayed
set expandtab                           " Converts tabs to spaces
set fileencoding=utf-8                  " The encoding written to file
set hidden                              " Required to keep multiple buffers open
set iskeyword+=-                        " treat dash separated words as a word text object
set mouse=a                             " Enable your mouse
set nofoldenable
set nohlsearch
set number relativenumber
set pumheight=10                        " Makes popup menu smaller
set shiftwidth=4
set smartindent                         " Makes indenting smart
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set softtabstop=4
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set tabstop=4
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set updatetime=300                      " Faster completion

let mapleader =" "

let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'
let g:indentLine_char = '▏'
let g:python_highlight_all = 1
let g:python_highlight_string_formatting = 0
let g:strip_whitespace_on_save = 1
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_nerdtree = 1

au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])

" Autoformat Pep8
map <leader>f :!autopep8 --in-place --aggressive --aggressive %<CR>:e<CR>:w<CR><CR>
map <leader>ff :CocCommand prettier.formatFile<CR>

" Code runner
map <leader>b :w<CR>:!./%<CR>
map <leader>n :w<CR>:!python3 %<CR>
map <leader>v :w<CR>:!BATS_RUN_SKIPPED=true bats %<CR>
map <leader>h :w<CR>:!python3 % > /tmp/a.out<CR>:split<CR>:e /tmp/a.out<CR><CR>

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

" File navigation and stuff
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nnoremap <C-b> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

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

function MyCustomHighlights()
    hi CocErrorFloat ctermfg=DarkGray
    hi Comment ctermfg=DarkGray
    hi LineNr ctermfg=DarkGray
    hi Pmenu ctermfg=DarkGray ctermbg=Black
    hi PmenuSel ctermfg=Black ctermbg=DarkGray
    hi Search ctermbg=LightYellow
    hi Visual ctermfg=Black ctermbg=DarkGray
    hi semshiBuiltin         ctermfg=Red
    hi semshiGlobal          ctermfg=Blue
    hi semshiImported        ctermfg=Blue cterm=bold gui=bold
    hi semshiSelected        ctermfg=231 ctermbg=DarkRed
    highlight VertSplit cterm=NONE
endfunction

call MyCustomHighlights()
