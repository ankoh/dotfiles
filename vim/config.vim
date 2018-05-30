call plug#begin('~/.vim/plugged')

Plug 'embear/vim-localvimrc'                " local vim configurations
Plug 'valloric/youcompleteme'               " autocompletion
Plug 'rdnetto/ycm-generator', { 'branch': 'stable'} " ycm generator
Plug 'rhysd/vim-clang-format'               " clang format
Plug 'Raimondi/delimitMate'                 " automatic closing of quotes, parenthesis, brackets, etc.
Plug 'scrooloose/nerdtree'                  " NERD tree
Plug 'itchyny/lightline.vim'                " status bar
Plug 'Xuyuanp/nerdtree-git-plugin'          " git status in NERDTree
Plug 'ctrlpvim/ctrlp.vim'                   " fuzzy file finder
Plug 'jeetsukumaran/vim-buffergator'        " buffer manager
Plug 'majutsushi/tagbar'                    " tagbar
Plug 'tpope/vim-fugitive'                   " git support
Plug 'airblade/vim-gitgutter'               " git support
Plug 'justinmk/vim-syntax-extra'            " bison, flex, c
" Plug 'godlygeek/csapprox'                   " approximate gvim plugin
Plug 'vim-utils/vim-man'                    " man pages
Plug 'fatih/vim-go'                         " go support
Plug 'keith/swift.vim'                      " swift support
Plug 'jalvesaq/nvim-r'                      " r support
Plug 'leafgarland/typescript-vim'           " typescript syntax
Plug 'Chiel92/vim-autoformat'               " autoformat things
Plug 'arcticicestudio/nord-vim'             " nord theme

call plug#end()

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
set expandtab              " insert spaces rather than tab for <Tab>
set smarttab               " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4              " the visible width of tabs
set softtabstop=4          " edit as if the tabs are 4 characters wide
set shiftwidth=4           " number of spaces to use for indent and unindent
set shiftround             " round indent to a multiple of 'shiftwidth'
" set mouse=c                " disable the mouse in vim to prevent clicks
if has('mouse')
   set mouse=a            " mouse support (e.g. copy selected without mouse)
endif
set backspace=indent,eol,start " backspace problem
set ttyfast                " faster redrawing
set lazyredraw             " draw lazy
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set laststatus=2           " show the satus line all the time
set hidden                 " buffers vs tabs
set foldmethod=syntax      " fold based on indent
set foldnestmax=10         " deepest fold is 10 levels
set nofoldenable           " don't fold by default
set foldlevel=1            " 1 fold opened by default
set so=7                   " keep 7 lines in front of the cursors - when moving vertical
set scrolloff=3            " lines of text around cursor
set cmdheight=1            " command bar height
set title                  " set terminal title
set nocompatible           " not compatible with vi
set autoread               " detect when a file is changed
set colorcolumn=121        " line width
set ignorecase             " case insensitive searching
set smartcase              " case-sensitive if expresson contains a capital letter
set hlsearch
set incsearch              " set incremental search, like modern browsers
set magic                  " set magic on, for regex
set showmatch              " show matching braces
set mat=2                  " how many tenths of a second to blink
syntax on                  " switch syntax highlighting on
set synmaxcol=256          " limit syntax highlighting to 256 chars"
set encoding=utf8
set number                 " show line numbers
set cursorline             " highlight cursor line
" set relativenumber         " show relative line numbers (DEADLY performance-wise)
set wrap                   " turn on line wrapping
set showbreak=…            " show ellipsis at breaking
set autoindent             " automatically set indent of new line
set smartindent            " use smarter indentation based on file type
set laststatus=2           " always show status bar
set fillchars+=stl:\ ,stlnc:\-      " If stl and stlnc have the same values they're set to ^
set wildignore+=.so,.swp,.zip,.o,.d,.dwo,.make,.a,link.txt,depend.internal,CXX.includecache,CMakeCache.txt

" Find (mark) visually selected text
" Credits: http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
" Replacement with: %s//<your-replacement-string>
vnoremap <C-M> y<ESC>/<C-R>"<CR>

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Window splits
nnoremap <leader>w <C-W>
nnoremap <leader>ws  :split<CR>
nnoremap <leader>w+ :exe "resize " . (winheight(0) * 12/10)<CR>
nnoremap <leader>w- :exe "resize " . (winheight(0) * 8/10)<CR>
nnoremap <leader>wv  :vsplit<CR>
nnoremap <leader>w< :exe "vertical resize " . (winwidth(0) * 12/10)<CR>
nnoremap <leader>w> :exe "vertical resize " . (winwidth(0) * 8/10)<CR>

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
" set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
" set showbreak=↪
nnoremap <leader>ic :set list!<CR>

" Terminal
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" Ignore some folders in ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|\DS_Store\|git$'

" YCM
let g:ycm_confirm_extra_conf=0                          " silently use .ycm_extra_conf.py
let g:ycm_auto_trigger=1                                " use auto trigger
let g:ycm_autoclose_preview_window_after_insertion=1    " hide the preview window after insertion

nnoremap <leader>gh :YcmCompleter GoToInclude<CR>
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gt :YcmCompleter GoTo<CR>
nnoremap <leader>gi :YcmCompleter GoToImprecise<CR>

" Builds

nnoremap <F7> :! set -x; test -d build && cd build && make -j16 && test -x tester && ./tester<CR>
nnoremap <F8> :! set -x; DEBUG=1 make -j16 && test -x bin/debug/tester && ./bin/debug/tester<CR>
nnoremap <F9> :! set -x; make -j16 && test -x bin/tester && ./bin/tester<CR>

" YCM TSX
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
autocmd BufEnter *.tsx set filetype=typescript

" Local Vimrc
let g:localvimrc_ask = 0

let g:lightline = {
    \ 'colorscheme': 'nord',
    \  }

" NERDtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 40 
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>m :NERDTreeToggle<CR>

" Buffergator
let g:buffergator_suppress_keymaps = 1
let g:buffergator_autoexpand_on_split = 0
nnoremap <leader>b :BuffergatorToggle<CR>

" CTag Tagbar
nnoremap <leader>ct :TagbarToggle<CR>

" CTag typescript support
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

" R nvim
let g:R_nvim_wd = 1

" Clang-Format
let g:clang_format#command = 'clang-format-5.0'
let g:clang_format#detect_style_file = 1

" Nord theme
augroup nord-overrides
    autocmd!
    autocmd ColorScheme nord highlight Comment ctermfg=13 guifg='#EBCB8B'
augroup END
colorscheme nord
