call plug#begin('~/.vim/plugged')

Plug 'embear/vim-localvimrc'                " local vim configurations
if has('nvim')                              " deoplete
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'Shougo/denite.nvim'
else
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'Shougo/denite.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }                                     " languageclient
Plug 'jackguo380/vim-lsp-cxx-highlight'     " semantic highlighting c++
Plug 'rhysd/vim-clang-format'               " clang format
Plug 'scrooloose/nerdtree'                  " NERDTree
Plug 'itchyny/lightline.vim'                " bottom status bar
Plug 'tpope/vim-fugitive'                   " git plugin
Plug 'airblade/vim-gitgutter'               " git in sidebar
Plug 'tmux-plugins/vim-tmux-focus-events'   " tmux focus events
Plug 'roxma/vim-tmux-clipboard'             " tmux clipboard
Plug 'rust-lang/rust.vim'                   " rustfmt
Plug 'jalvesaq/nvim-r'                      " r plugin
Plug 'fatih/vim-go'                         " go support
Plug 'elzr/vim-json'                        " WTF hidden json quotes
Plug 'edkolev/tmuxline.vim'                 " tmux line
Plug 'terryma/vim-multiple-cursors'         " multiple cursors
Plug 'rhysd/vim-grammarous'                 " grammar checks
Plug 'jeetsukumaran/vim-buffergator'        " buffer manager
Plug 'lervag/vimtex'                        " latex plugin
Plug 'HerringtonDarkholme/yats.vim'         " typescript syntax
Plug 'shougo/vimproc.vim', {'do' : 'make'}  " tsuquyomi dependency
Plug 'quramy/tsuquyomi'                     " typescript language servers are meh
Plug 'prettier/vim-prettier', {
    \ 'do': 'npm install',
    \ 'branch': 'release/0.x',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html']
    \ }                                     " formatter for the web

" TEST: FZF instead of CTRLP
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" Open R in tmux split
let g:R_source = '~/.dotfiles/vim/tmux_split.vim'

" I really don't like conceal.
" Indentline breaks with this setting so i'll just stop using it.
" But hidden JSON quotes and Tex Math-mode symbols drive me crazy.
set conceallevel=0

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
" Neovim supports truecolor schemes (!).
" However, this has the unpleasant side effect that some terminals are barely usable (e.g. Terminal.app).
" set termguicolors
"
" For now, we can just replace the 256 color palette with the gruvbox-palette on shell init.
colorscheme gruvbox

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
nnoremap <C-P> :call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'}))<CR>
"nnoremap <C-P> :Files<CR>

" Special characters
set invlist
" set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
" set showbreak=↪
nnoremap <leader>ic :set list!<CR>

" Window splits
nnoremap <leader>f za<CR>
nnoremap <leader>F zR<CR>

" Grammarous
nmap <leader>ss :GrammarousCheck<CR>
nmap <leader>ssen :GrammarousCheck --lang=en<CR>
nmap <leader>ssde :GrammarousCheck --lang=de<CR>
nmap <leader>sn <Plug>(grammarous-move-to-next-error)
nmap <leader>sj <Plug>(grammarous-move-to-next-error)
nmap <leader>sp <Plug>(grammarous-move-to-previous-error)
nmap <leader>sk <Plug>(grammarous-move-to-previous-error)
nmap <leader>si <Plug>(grammarous-remove-error)
nmap <leader>sr <Plug>(grammarous-reset)

" CCLS command
let s:ccls_settings = {
    \ 'highlight': { 'lsRanges' : v:true },
    \ }
let s:ccls_command = ['~/.local/bin/ccls', '-init=' . json_encode(s:ccls_settings)]
let s:tsls_command = ['typescript-language-server', '--stdio']

" LanguageClient
let g:LanguageClient_autoStart = 1
let g:LanguageClient_useVirtualText = "Diagnostics"
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_diagnosticsList = "Quickfix"
let g:LanguageClient_diagnosticsMaxSeverity = "Hint"
let g:LanguageClient_serverCommands = {
    \   'rust': ['rust-analyzer'],
    \   'python': ['pyls'],
    \   'dart': ['dart_language_server'],
    \   'cpp': s:ccls_command,
    \   'c': s:ccls_command
    \ }
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
set formatexpr=LanguageClient_textDocument_rangeFormatting()
nnoremap <leader>gf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>gh :call LanguageClient#textDocument_hover()<cr>
nnoremap <leader>gi :call LanguageClient#findLocations({'method':'$ccls/inheritance','flat':v:true,'level':3,'derived':v:true})<cr>
nnoremap <leader>gr :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <leader>gt :call LanguageClient#textDocument_definition()<CR>
nnoremap <F5> :call LanguageClient#textDocument_rename()<CR>

" LSP status indicator
augroup LanguageClient_callbacks
    au!
    au User LanguageClientStarted call LSPUpdateStatus(1)
    au User LanguageClientStopped call LSPUpdateStatus(0)
    au User LanguageClientDiagnosticsChanged call LSPUpdateStatus(1)
augroup END
function! LSPDiagnosticsCount(type) abort
    let lsp_bufnr = bufnr('%')
    let lsp_qflist = getqflist()
    return len(filter(lsp_qflist, {index, dict -> dict['bufnr'] == lsp_bufnr && dict['type'] == a:type}))
endfunction
function! LSPUpdateStatus(status) abort
    let g:lsp_warnings = LSPDiagnosticsCount('W')
    let g:lsp_errors = LSPDiagnosticsCount('E')
    call lightline#update()
endfunction
function! LightlineLSPOK() abort
    return (g:lsp_warnings + g:lsp_errors) == 0 ? '✓' : ''
endfunction
function! LightlineLSPWarnings() abort
    return g:lsp_warnings > 0 ? printf('%d ▲', g:lsp_warnings) : ''
endfunction
function! LightlineLSPErrors() abort
    return g:lsp_errors > 0 ? printf('%d ✗', g:lsp_errors) : ''
endfunction

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
set completeopt-=preview

" Spellchecking
autocmd BufRead, BufNewFile *.tex setlocal spell spelllang=en_us
autocmd BufRead, BufNewFile *.txt setlocal spell spelllang=en_us

" Local Vimrc
let g:localvimrc_ask = 0

let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ 'active': {
    \   'left': [[ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ]],
    \   'right': [['lineinfo'], ['percent'], ['lsp_ok', 'lsp_warnings', 'lsp_errors']],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \ },
    \ 'component_expand': {
    \   'lsp_warnings': 'LightlineLSPWarnings',
    \   'lsp_errors': 'LightlineLSPErrors',
    \   'lsp_ok': 'LightlineLSPOK',
    \ },
    \ 'component_type': {
    \   'lsp_warnings': 'warning',
    \   'lsp_errors': 'error',
    \   'lsp_ok': 'ok',
    \ },
    \ }

" NERDtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 40 
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>m :NERDTreeToggle<CR>

" tsuquyomi bindings
let g:tsuquyomi_completion_detail = 1
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd FileType typescript setlocal completeopt+=menu,preview
autocmd FileType typescriptreact setlocal completeopt+=menu,preview
autocmd FileType typescript,typescriptreact nnoremap <buffer> <leader>gt :TsuDefinition<CR>

" R nvim
let g:R_nvim_wd = 1

" Clang-Format
" let g:clang_format#command = '~/.local/bin/clang-format'
let g:clang_format#detect_style_file = 1

" Don't autoformat
let g:prettier#autoformat = 0

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* Gitgrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
command! -bang -nargs=* Gitgrepi
  \ call fzf#vim#grep(
  \   'git grep -i --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Disable syntax highlighting for bison and flex
autocmd! bufreadpost *.y set syntax=off
autocmd! bufreadpost *.yh set syntax=off
autocmd! bufreadpost *.l set syntax=off
