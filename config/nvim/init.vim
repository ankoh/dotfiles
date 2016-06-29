" Section Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" utilities
Plug 'ctrlpvim/ctrlp.vim'              " fuzzy file finder, mapped to <leader>t
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons' " file drawer
Plug 'Raimondi/delimitMate'            " automatic closing of quotes, parenthesis, brackets, etc.
Plug 'vim-airline/vim-airline'         " fancy statusline
Plug 'vim-airline/vim-airline-themes'  " themes for vim-airline
Plug 'tpope/vim-fugitive'              " amazing git wrapper for vim

call plug#end()

" }}}

" Section General {{{

set nocompatible     " not compatible with vi
set autoread         " detect when a file is changed

" Learn it the hard way
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Alternate map leader
let mapleader = '<'
let g:mapleader = '<'

set history=1000           " change history to 1000
set textwidth=120

" Tabs
set expandtab              " insert tabs rather than spaces for <Tab>
set smarttab               " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=3              " the visible width of tabs
set softtabstop=3          " edit as if the tabs are 4 characters wide
set shiftwidth=3           " number of spaces to use for indent and unindent
set shiftround             " round indent to a multiple of 'shiftwidth'
set completeopt+=longest   " use longes match during completion

if has('mouse')
    set mouse=a            " mouse support (e.g. copy selected without mouse)
endif
set clipboard=unnamed      " copy to system clipboard
set ttyfast                " faster redrawing

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set laststatus=2           " show the satus line all the time

" }}}

" Section User Interface {{{

set foldmethod=syntax      " fold based on indent
set foldnestmax=10         " deepest fold is 10 levels
set nofoldenable           " don't fold by default
set foldlevel=1            " 1 fold opened by default

set so=7                   " keep 7 lines in front of the cursors - when moving vertical
set wildmenu               " enhanced command line completion
set hidden                 " current buffer can be put into background
set showcmd                " show incomplete commands
set wildmode=list:longest  " complete files like a shell
set scrolloff=3            " lines of text around cursor
set shell=$SHELL
set cmdheight=1            " command bar height

set title                  " set terminal title

" Searching
set ignorecase             " case insensitive searching
set smartcase              " case-sensitive if expresson contains a capital letter
set hlsearch
set incsearch              " set incremental search, like modern browsers
set magic                  " Set magic on, for regex

set showmatch              " show matching braces
set mat=2                  " how many tenths of a second to blink

syntax on                  " switch syntax highlighting on

set encoding=utf8
set number                 " show line numbers

set wrap                   "turn on line wrapping
set wrapmargin=8           " wrap lines when coming within n characters from side
set linebreak              " set soft wrapping
set showbreak=…            " show ellipsis at breaking

set autoindent             " automatically set indent of new line
set smartindent

" }}}

" Section Mappings {{{

set invlist
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
set showbreak=↪
nmap <leader>l :set list!<cr>

map <C-n> :NERDTreeToggle<CR>

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'
" }}}
