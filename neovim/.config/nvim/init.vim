" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|

call plug#begin('~/.config/nvim/plugged')

    Plug 'Raimondi/delimitMate'
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'Yggdroot/indentLine'
    Plug 'tpope/vim-commentary'
    Plug 'tweekmonster/startuptime.vim'
    Plug 'vim-python/python-syntax'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'preservim/nerdtree'
    Plug 'ThePrimeagen/vim-be-good'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'ryanoasis/vim-devicons'
    Plug 'lilydjwg/colorizer'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

syntax enable                           " Enables syntax highlighing

set clipboard=unnamedplus
set nohlsearch
set hidden                              " Required to keep multiple buffers open
set nofoldenable
set encoding=utf-8                      " The encoding displayed
set fileencoding=utf-8                  " The encoding written to file
set pumheight=10                        " Makes popup menu smaller
set cmdheight=1                         " More space for displaying messages
set iskeyword+=-                        " treat dash separated words as a word text object
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set number relativenumber
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

let mapleader =" "
let g:indentLine_char = '▏'
let g:airline_theme='minimalist'
let g:python_highlight_all = 1
let g:python_highlight_string_formatting = 0

" Autoformat Pep8
map <leader>f :!autopep8 --in-place --aggressive --aggressive %<CR>:e<CR>:w<CR>

" Code runner
map <leader>n :w<CR>:!python3 %<CR>
map <leader>b :w<CR>:!BATS_RUN_SKIPPED=true bats %<CR>

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
    hi Comment ctermfg=DarkGray
    hi CocErrorFloat ctermfg=DarkGray
    hi Pmenu ctermfg=DarkGray ctermbg=Black
    hi PmenuSel ctermfg=Black ctermbg=DarkGray
    hi LineNr ctermfg=DarkGray
    hi Visual ctermfg=Black ctermbg=DarkGray
    hi Search ctermbg=LightYellow
    hi semshiGlobal          ctermfg=Blue
    hi semshiImported        ctermfg=Blue cterm=bold gui=bold
    hi semshiBuiltin         ctermfg=Red
    hi semshiSelected        ctermfg=231 ctermbg=DarkRed
endfunction

call MyCustomHighlights()
