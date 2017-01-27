call plug#begin('~/.config/nvim/plugged')

Plug 'embear/vim-localvimrc'                " local vim configurations
Plug 'valloric/youcompleteme'               " autocompletion
Plug 'rdnetto/ycm-generator', { 'branch': 'stable'} " ycm gen
Plug 'Raimondi/delimitMate'                 " automatic closing of quotes, parenthesis, brackets, etc.
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons' " file drawer
Plug 'ctrlpvim/ctrlp.vim'                   " fuzzy file finder, mapped to <leader>t
Plug 'majutsushi/tagbar'                    " tagbar
Plug 'tpope/vim-fugitive'                   " git support
Plug 'vim-airline/vim-airline'              " fancy statusline
Plug 'vim-airline/vim-airline-themes'       " themes for vim-airline
" Plug 'flazz/vim-colorschemes'             " colorschemes
Plug 'crusoexia/vim-monokai'                " monokai
Plug 'leafgarland/typescript-vim'           " typescript syntax
Plug 'quramy/tsuquyomi'                     " typescript completion
Plug 'shougo/vimproc.vim', {'do' : 'make'}  " async execution for tsuquyomi
Plug 'lervag/vimtex'                        " latex support

call plug#end()

colorscheme monokai
" colorscheme kate
" colorscheme lucius
" colorscheme Tomorrow
" colorscheme Tomorrow-Night

set nocompatible     " not compatible with vi
set autoread         " detect when a file is changed

" Learn it the hard way
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Alternate map leader
let mapleader = ','
let g:mapleader = ','

" YCM hates C-c
" https://github.com/Valloric/YouCompleteMe/blob/master/README.md
inoremap jk <Esc>

set history=1000           " change history to 1000
set textwidth=0

" <Tab>
set expandtab              " insert spaces rather than tab for <Tab>
set smarttab               " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4              " the visible width of tabs
set softtabstop=4          " edit as if the tabs are 4 characters wide
set shiftwidth=4           " number of spaces to use for indent and unindent
set shiftround             " round indent to a multiple of 'shiftwidth'

if has('mouse')
    set mouse=a            " mouse support (e.g. copy selected without mouse)
endif
set clipboard+=unnamedplus " copy to system clipboard
set ttyfast                " faster redrawing

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set laststatus=2           " show the satus line all the time

set foldmethod=syntax      " fold based on indent
set foldnestmax=10         " deepest fold is 10 levels
set nofoldenable           " don't fold by default
set foldlevel=1            " 1 fold opened by default

set so=7                   " keep 7 lines in front of the cursors - when moving vertical
set scrolloff=3            " lines of text around cursor
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
set synmaxcol=256          " limit syntax highlighting to 256 chars"

set encoding=utf8
set number                 " show line numbers
" set relativenumber         " show relative line numbers (DEADLY performance-wise)

set wrap                   " turn on line wrapping
set showbreak=…            " show ellipsis at breaking

set autoindent             " automatically set indent of new line
set smartindent

" Window operations
nnoremap <leader>w <C-W>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Fast scrolling if ctrl key is not mapped correctly
nnoremap <leader>f <C-F>
nnoremap <leader>b <C-B>

" Tabs
nnoremap <leader>tj :tabfirst<CR>
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>th :tabprev<CR>
nnoremap <leader>tk :tablast<CR>
nnoremap <leader>tn :tabnew<Space>
nnoremap <leader>tt :tabedit<Space>
nnoremap <leader>td :tabclose<CR>

" Fix TMUX+NVIM C-H bug
" https://github.com/neovim/neovim/issues/2048
nmap <BS> <C-W>h

" Location list
nnoremap <leader>ln :lne<CR>
nnoremap <leader>lp :lp<CR>
nnoremap <leader>lc :lcl<CR>

" Special characters
set invlist
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
nnoremap <leader>ic :set list!<CR>

" Terminal
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
endif

" YCM
let g:ycm_confirm_extra_conf=0                          " silently use .ycm_extra_conf.py
let g:ycm_auto_trigger=0                                " disable auto trigger
let g:ycm_autoclose_preview_window_after_completion=1   " hide the preview window
let g:ycm_autoclose_preview_window_after_insertion=1    " hide the preview window

nnoremap <leader>gh :YcmCompleter GoToInclude<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gi :YcmCompleter GoToDefinition<CR>
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>gf :YcmCompleter GoToImprecise<CR>

" YCM Typescript
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" Local Vimrc
let g:localvimrc_ask=0

" NERDtree
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize = 40 
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>m :NERDTreeToggle<CR>

" CTag Tagbar
nnoremap <leader>ct :TagbarToggle<CR>

" Airline
let g:airline_powerline_fonts=1
let g:airline_theme='zenburn'
