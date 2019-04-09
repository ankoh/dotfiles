call plug#begin('~/.vim/plugged')

Plug 'embear/vim-localvimrc'                " local vim configurations
if has('nvim')                              " deoplete
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }                                     " languageserver
Plug 'rhysd/vim-clang-format'               " clang format
Plug 'scrooloose/nerdtree'                  " NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'          " NERDTree git status
Plug 'Raimondi/delimitMate'                 " autocompletion for quotes
Plug 'itchyny/lightline.vim'                " bottom status bar
Plug 'ap/vim-buftabline'                    " top tab line with buffers
Plug 'tpope/vim-fugitive'                   " git plugin
Plug 'airblade/vim-gitgutter'               " git in sidebar
Plug 'tmux-plugins/vim-tmux-focus-events'   " tmux focus events
Plug 'roxma/vim-tmux-clipboard'             " tmux clipboard
Plug 'arcticicestudio/nord-vim'             " nord theme
Plug 'leafgarland/typescript-vim'           " typescript syntax highlighting
Plug 'rust-lang/rust.vim'                   " rustfmt
Plug 'jalvesaq/nvim-r'                      " r plugin
Plug 'yggdroot/indentline'                  " indentation guides
Plug 'fatih/vim-go'                         " go support
Plug 'dart-lang/dart-vim-plugin'            " dart syntax highlighting
Plug 'thosakwe/vim-flutter'                 " flutter commands

" TEST: FZF instead of CTRLP
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" Learn it the hard way
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Alternate map leader
let mapleader = ','
let g:mapleader = ','

" JK instead of enter
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
" if has('mouse')
"    set mouse=a            " mouse support (e.g. copy selected without mouse)
" endif
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
set noswapfile             " disable swap files
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
set wrap                   " turn on line wrapping
set showbreak=…            " show ellipsis at breaking
set autoindent             " automatically set indent of new line
set smartindent            " use smarter indentation based on file type
set laststatus=2           " always show status bar
set fillchars+=stl:\ ,stlnc:\-      " If stl and stlnc have the same values they're set to ^
set wildignore+=.so,.swp,.zip,.o,.d,.dwo,.make,.a,link.txt,depend.internal,CXX.includecache,CMakeCache.txt
set clipboard=unnamed      " use system clipboard

" Paste mode
set pastetoggle=<F3>

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

" Buffer tab line
nnoremap <leader>tl :bnext<CR>
nnoremap <leader>th :bprev<CR>

" Fix TMUX+NVIM C-H bug
" https://github.com/neovim/neovim/issues/2048
nmap <BS> <C-W>h

" Location list
nnoremap <leader>ln :lne<CR>
nnoremap <leader>lp :lp<CR>
nnoremap <leader>lc :lcl<CR>

" FZF ctrl-p mode
nnoremap <C-P> :Files<CR>

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

" LanguageClient
let g:LanguageClient_serverCommands = {
    \   'rust': ['rustup', 'run', 'stable', 'rls'],
    \   'python': ['pyls'],
    \   'typescript': ['javascript-typescript-stdio'],
    \   'javascript': ['javascript-typescript-stdio'],
    \   'dart': ['dart_language_server'],
    \   'cpp': [
    \       '~/.local/bin/ccls',
    \       '--log-file=/tmp/ccls.log',
    \       '--init={"cacheDirectory":"/tmp/ccls"}'
    \   ],
    \   'c': [
    \       '~/.local/bin/ccls',
    \       '--log-file=/tmp/ccls.log',
    \       '--init={"cacheDirectory":"/tmp/ccls"}'
    \   ],
    \ }
let g:LanguageClient_autoStart = 1
set formatexpr=LanguageClient_textDocument_rangeFormatting()
nnoremap <leader>gt :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>gr :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <leader>gh :call LanguageClient#findLocations({'method':'$ccls/inheritance','flat':v:true,'level':3,'derived':v:true})<cr>
nnoremap <F5> :call LanguageClient#textDocument_rename()<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#manual_complete()

" Spellchecking
autocmd BufRead, BufNewFile *.tex setlocal spell spelllang=en_us
autocmd BufRead, BufNewFile *.txt setlocal spell spelllang=en_us

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

" R nvim
let g:R_nvim_wd = 1

" Clang-Format
" let g:clang_format#command = '~/.local/bin/clang-format'
let g:clang_format#detect_style_file = 1

" Nord theme
augroup nord-overrides
    autocmd!
    autocmd ColorScheme nord highlight Comment ctermfg=13 guifg='#EBCB8B'
augroup END
colorscheme nord
