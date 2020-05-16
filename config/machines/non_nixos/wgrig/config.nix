{
  packageOverrides = pkgs: with pkgs; {
    myVim = vim_configurable.customize {
      name = "vim-with-plugins";
    };
    myNeovim = neovim.override {
      configure = {
	customRC = ''
	  "" General Settings {{{
	    " turn on filetype detection and indentation
	    " filetype indent plugin on
	    " set tags file to search in parent directories with tags
	    set tags=tags;
	    " enable line numbers
	    set number
	    " Jump to last cursor position when opening files
	    " See |last-position-jump|.
	    :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	    :set pastetoggle=<F2>
	    :set clipboard=unnamedplus
	    :set backspace=2 " make backspace work like most other programs
	    :syntax on
	  " }}}


	  "" Theme settings {{{
	    " airline :
	    " for terminology you will need either to export TERM='xterm-256color'
	    " or run it with '-2' option
	    let g:airline_powerline_fonts = 1
	    set laststatus=2
	    au VimEnter * exec 'AirlineTheme wombat'
	    colorscheme spacecamp
	  "}}}

	  "" Syntastic settings {{{
	    set statusline+=%#warningmsg#
	    set statusline+=%#{SyntasticStatuslineFlag()}
	    set statusline+=%*
	    let g:syntastic_always_populate_loc_list = 1
	    let g:syntastic_auto_loc_list = 1
	    let g:syntastic_check_on_wq = 0
	  "}}}

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

	 "" Indentation {{{
	    au FileType haskell         setl sw=4 sts=2 et
	    au FileType json            setl sw=2 sts=2 et
	    au FileType javascript      setl sw=2 sts=2 et
	    au FileType js              setl sw=2 sts=2 et
	    au FileType javascript.jsx  setl sw=2 sts=2 et
	    au FileType php             setl sw=2 sts=2 et
	    au FileType markdown        setl sw=2 sts=2 et
	    au FileType qml             setl sw=2 sts=2 et
	    au FileType yaml            setl sw=2 sts=2 et
	    au FileType nix             setl sw=2 sts=2 et
	    au FileType Jenkinsfile     setl sw=2 sts=2 et
	    au FileType groovy          setl sw=2 sts=2 et
	    au FileType python          setl sw=2 sts=2 et
	    au FileType kv              setl sw=2 sts=2 et
	    au FileType typescript      setl sw=2 sts=2 et
	    au FileType ts              setl sw=2 sts=2 et
	  "}}}

	  "" Tagbar Settings {{{
	    nmap <F8> :TagbarToggle<CR>
	    " Width of the Tagbar window in characters.
	    let g:tagbar_width = 80
	    " Width of the Tagbar window when zoomed.
	    " Use the width of the longest currently visible tag.
	    let g:tagbar_zoomwidth = 0
	  "}}}

	  "" YouCompleteMe Settings {{{
	    let g:ycm_server_keep_logfiles = 0
	  "}}}

	  "" Misc Settings {{{
	    let g:rainbow_active = 1
	  "}}}
	'';
	packages.myVimPackage = with pkgs.vimPlugins; {
	  start = [
	    SpaceCamp
	    polyglot
	    rainbow
	    tagbar
	    LanguageClient-neovim
	    YouCompleteMe
	    colorizer
	    fugitive
	    nerdcommenter
	    syntastic
	    vim-airline
	    vim-airline-themes
	    vim-autoformat
	    vim-illuminate
	    vim-nix
	  ];
	  opt = [ ];
	};
      };
    };
  };
}
