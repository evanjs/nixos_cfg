''
"" Language Client Settings {{{
let g:LanguageClient_autoStart = 1

nnoremap <F5>  :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>

"map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
"map <Leader>lg :call LanguageClient#textDocument_definition(<CR>
"map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
"map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
"map <Leader>lb :call LanguageClient#textDocument_references()<CR>
"map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
"map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
" }}}
''
