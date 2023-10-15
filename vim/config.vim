call plug#begin('~/.vim/plugged')

" Disable most plugins when running as vscode backend
if exists('g:vscode')

else
Plug 'scrooloose/nerdtree'                  " NERDTree
Plug '~/.fzf'                               " FZF instead of CTRLP
Plug 'junegunn/fzf.vim'
endif

call plug#end()

" Learn it the hard way
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Alternate map leader
let mapleader = ','
let g:mapleader = ','

" Terminal
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" JK instead of escape
inoremap jk <Esc>

syntax on                  " switch syntax highlighting on
set history=10000          " change history to 10000
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
" set ttyfast                " faster redrawing
" set lazyredraw             " draw lazy (leads to rendering artifacts in alacritty)
" set relativenumber         " relative line numbering
set backupdir=/tmp
set directory=/tmp
set laststatus=2           " show the satus line all the time
set hidden                 " buffers vs tabs
set foldmethod=syntax      " fold based on syntax highlighting
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
set synmaxcol=1024         " limit syntax highlighting to 1024 chars
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

" Color scheme
colorscheme onedark

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
" nnoremap <C-P> :call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'}))<CR>
nnoremap <C-P> :Files<CR>

" Special characters
set invlist
" set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
" set showbreak=↪
nnoremap <leader>ic :set list!<CR>

" Window splits
nnoremap <leader>f za<CR>
nnoremap <leader>F zR<CR>

" NERDtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 40 
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>m :NERDTreeToggle<CR>

" R nvim
let g:R_nvim_wd = 1

" Disable syntax highlighting for bison and flex
autocmd! bufreadpost *.y set syntax=off
autocmd! bufreadpost *.yh set syntax=off
autocmd! bufreadpost *.l set syntax=off
