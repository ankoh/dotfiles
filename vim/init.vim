" Neovim configuration

" Get current directory path
" Credits go to StackOverflow:
" http://stackoverflow.com/questions/4976776/how-to-get-path-to-the-current-vimscript-being-executed
let s:dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:config = s:dir.'/config.vim'

" Select python host program
let g:python_version = matchstr(system("python --version | cut -f2 -d' '"), '^[0-9]')
if g:python_version =~ 3
    let g:python2_host_prog = "/usr/local/bin/python2"
else
    let g:python3_host_prog = "/usr/local/bin/python3"
endif

" Then just source config.vim
exe 'source' s:config
