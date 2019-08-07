''
"" General Settings {{{
" turn on filetype detection and indentation
" filetype indent plugin on

" set tags file to search in parent directories with tags
set tags=tags;

" Jump to last cursor position when opening files
" See |last-position-jump|.
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

:set pastetoggle=<F2>
:set clipboard=unnamedplus
:set backspace=2 " make backspace work like most other programs

:syntax on
" }}}
''
