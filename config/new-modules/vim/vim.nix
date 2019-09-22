{ config, pkgs, lib, ... }:
with lib;

let
  rust-language-server = ((pkgs.latest.rustChannels.stable.rust.override { extensions = [ "rls-preview" ]; }));
  rust-nightly = pkgs.latest.rustChannels.nightly.rust;
  dag = import ../../external/home-manager/modules/lib/dag.nix { inherit lib; };
in
  {
    options.mine.vim.enable = mkEnableOption "vim config";
    config.mine.userConfig = mkIf config.mine.vim.enable {

      nixpkgs.overlays = [(self: super: {
      })];

      programs.neovim = {
        enable = true;

        viAlias = true;
        vimAlias = true;
        withPython = false;
        withPython3 = true;

        plugins = with pkgs.vimPlugins; [
          colorizer
          fugitive
          ghc-mod-vim
          haskell-vim
          LanguageClient-neovim
          latex-box
          neomake
          nerdcommenter
          nerdtree
          polyglot
          rainbow
          ranger-vim
          rust-vim
          SpaceCamp
          syntastic
          vim-airline
          vim-airline-themes
          vim-autoformat
          vim-illuminate
          vim-latex-live-preview
          vimtex
          YouCompleteMe
        ];

        extraConfig = ''
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

            "" Rust Settings {{{
            let g:rustfmt_autosave = 1
            let g:syntastic_rust_checkers = ['rustc']
            let g:LanguageClient_serverCommands = { 'rust': ['${rust-nightly}/bin/rls'] }
            "}}}


            "" YouCompleteMe Settings {{{
            let g:ycm_server_keep_logfiles = 0
            "}}}

            "" Tex Settings {{{
            let g:vimtex_log_verbose = 1
	    let g:livepreview_previewer = '${pkgs.okular}/bin/okular'
            "}}}

            "" Misc Settings {{{
            let g:rainbow_active = 1
            "}}}
            
        '';
      };
    };
  }

