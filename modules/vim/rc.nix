''
        " turn on filetype detection and indentation
        filetype indent plugin on

        " set tags file to search in parent directories with tags
        set tags=tags;
        
        " Jump to last cursor position when opening files
        " See |last-position-jump|.
        :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

        set statusline+=%#warningmsg#
        set statusline+=%#{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_wq = 0

        " hie
        let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper'] }

        nnoremap <F5>  :call LanguageClient_contextMenu()<CR>
        map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
        map <Leader>lg :call LanguageClient#textDocument_definition(<CR>
        map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
        map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
        map <Leader>lb :call LanguageClient#textDocument_references()<CR>
        map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
        map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

        "if has ("autocmd")
        "  augroup templates
        " disabled for now - need to find where Nix puts the runtime directory
        "    autocmd BufNewFile *.nix 0r $HOME/.vim/templates/skeleton.nix
        "  augroup END
        "endif

        au FileType haskell     setl sw=4 sts=2 et
        au FileType json        setl sw=2 sts=2 et
        au FileType javascript  setl sw=2 sts=2 et
        au FileType php         setl sw=4 sts=2 et
        au FileType markdown    setl sw=2 sts=2 et
        au FileType qml         setl sw=2 sts=2 et
        au FileType yaml        setl sw=2 sts=2 et
        au FileType nix	        setl sw=2 sts=2 et
        au FileType Jenkinsfile setl sw=2 sts=2 et
        au FileType groovy      setl sw=2 sts=2 et
        :set pastetoggle=<F2>
        :set clipboard=unnamedplus
        :set backspace=2 " make backspace work like most other programs

        :syntax on
''
