" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|

call plug#begin('~/.config/nvim/plugged')

    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    Plug 'godlygeek/tabular'
    Plug 'dylanaraps/wal.vim'
    Plug 'Raimondi/delimitMate'
    Plug 'Chiel92/vim-autoformat'
    Plug 'ThePrimeagen/vim-be-good'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'lilydjwg/colorizer'
    Plug 'mg979/vim-visual-multi'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'preservim/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'tpope/vim-commentary'
    Plug 'tweekmonster/startuptime.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'       " Must be after vim-airline
    Plug 'EdenEast/nightfox.nvim'
    Plug 'catppuccin/nvim', {'as': 'catppuccin'}
    Plug 'ellisonleao/gruvbox.nvim'

call plug#end()

syntax enable                           " Enables syntax highlighing

" set background=dark
colorscheme wal
" colorscheme catppuccin

set autochdir                           " Your working directory will always be the same as your worki
set autoindent                          " Good auto indent
set clipboard=unnamedplus
set cmdheight=1                         " More space for displaying messages
set encoding=utf-8                      " The encoding displayed
set expandtab                           " Converts tabs to spaces
set fileencoding=utf-8                  " The encoding written to file
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
set hidden                              " Required to keep multiple buffers open
set iskeyword+=-                        " treat dash separated words as a word text object
set mouse=a                             " Enable your mouse
set nofoldenable
set hlsearch
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
set incsearch

let mapleader =" "

let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:python_highlight_string_formatting = 0
let g:python_highlight_all = 1
let g:strip_whitespace_on_save = 1
let g:airline_skip_empty_sections = 1

au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])

" Output the current syntax group
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Vim terminal
tnoremap <Esc> <C-\><C-n>

" Autoformat
noremap <leader>f :Autoformat<CR>

" Fzf
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <Leader>o :Files ~<CR>

" Code runner
map <leader>b :w<CR>:!./%<CR>
map <leader>n :w<CR>:!python3 %<CR>
map <leader>l :w<CR>:!lua %<CR>
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
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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
nnoremap <C-Q> :bdelete<CR>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

function MyCustomHighlights()
    hi CocFloating                                   ctermfg =130      ctermbg =Black
    hi CocErrorFloat                                 ctermfg =130      ctermbg =Black
    hi CocHintFloat                                  ctermfg =130      ctermbg =Black
    hi CocWarningFloat                               ctermfg =130      ctermbg =Black
    hi Comment                                       ctermfg =DarkGray
    hi CursorLineNr                                  ctermfg =DarkRed
    hi LineNr                                        ctermfg =DarkGray
    hi Pmenu                                         ctermfg =Black    ctermbg =DarkGray
    hi PmenuSel                                      ctermfg =DarkGray ctermbg =Black
    hi PmenuSbar                                                       ctermbg =Black
    hi Search                                        ctermfg =Black    ctermbg =DarkGray
    hi StatusLine                                    ctermfg =235
    hi StatusLineNC                                  ctermfg =235
    hi VertSplit                                                       ctermbg =NONE
    hi Visual                                        ctermfg =DarkGray ctermbg =Black
    hi IndentBlanklineChar                           ctermfg =DarkGray
endfunction

call MyCustomHighlights()
