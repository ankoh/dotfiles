" Neovim configuration

" Get current directory path
" Credits go to StackOverflow:
" http://stackoverflow.com/questions/4976776/how-to-get-path-to-the-current-vimscript-being-executed
let s:dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:config = s:dir.'/config.vim'


" Then just source config.vim
exe 'source' s:config
