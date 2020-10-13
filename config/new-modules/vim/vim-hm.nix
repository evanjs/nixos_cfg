{ config, pkgs, lib, ... }:
with lib;
let
  isTexEnabled = config.mine.tex.enable or false;
  rust-language-server = (pkgs.latest.rustChannels.stable.rust.override { extensions = [ "rls-preview" ]; });
  rust-nightly = pkgs.latest.rustChannels.nightly.rust;
    dag = import ../../external/home-manager/modules/lib/dag.nix { inherit lib; };

    loadPlugin = plugin: ''
       set rtp^=${plugin.rtp}
       set rtp+=${plugin.rtp}/after
     '';

  # This was merged with https://github.com/NixOS/nixpkgs/pull/98667 and is currently in nixos-unstable-small
  # Remove this "channel" once the commit makes it into nixos-unstable
  lsp_ext_nvim_pr = import (fetchTarball
    "https://github.com/evanjs/nixpkgs/archive/4eff214a577370c08847e2a3fef9cb63d5e47c98.tar.gz") {
  };
  plugins = with pkgs.vimPlugins; [
    colorizer
    fugitive
    ghc-mod-vim
    haskell-vim
    neomake
    nerdcommenter
    nerdtree
    polyglot
    rainbow
    ranger-vim
    rust-vim
    SpaceCamp
    syntastic
    tagbar
    vim-airline
    vim-airline-themes
    vim-autoformat
    vim-illuminate
    YouCompleteMe

    nvim-lspconfig
    completion-nvim
    diagnostic-nvim

  ] ++ optionals isTexEnabled (with pkgs.vimPlugins; [
    latex-box
    vim-latex-live-preview
    vimtex
  ]) ++ (with lsp_ext_nvim_pr.vimPlugins; [
    lsp_extensions-nvim
  ]);

  environment.systemPackages = with pkgs; [
    rust-analyzer
  ];
  #])));
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped.overrideAttrs(o: {
      src = pkgs.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "b9ceac4650a7d7b731828a4fb82b92d01e88752b";
        sha256 = "0h97693mjl5xbgzbpnvy817rlwcb8zhrh4xgg555qhgx9n4k6vz8";
      };
    });

    viAlias = true;
    vimAlias = true;
    withPython = false;
    withPython3 = true;


    extraConfig = ''
    	" Workaround for broken handling of packpath by vim8/neovim for ftplugins -- see https://github.com/NixOS/nixpkgs/issues/39364#issuecomment-425536054 for more info
	filetype off | syn off
	${builtins.concatStringsSep "\n"
	(map loadPlugin (plugins ++ (config.mine.vim.extraPlugins or [])))}
	filetype indent plugin on | syn on

      "" General Settings {{{
      filetype indent plugin on

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
      " TODO: How can this be abstracted/configured from expressions that import this?
      colorscheme ${config.mine.vim.colorscheme or "spacecamp"}
      "}}}

      "" Syntastic settings {{{
      set statusline+=%#warningmsg#
      set statusline+=%#{SyntasticStatuslineFlag()}
      set statusline+=%*

      let g:syntastic_always_populate_loc_list = 1
      let g:syntastic_auto_loc_list = 1
      let g:syntastic_check_on_wq = 0
      "}}}

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
      " Let's try using Rust-analyzer
      set completeopt=menuone,noinsert,noselect

      " Avoid showing extra messages when using completion
      " set shortmess+=c

      let g:ycm_language_server =
      \ [
      \   {
      \     'name': 'rust',
      \     'cmdline': ['rust-analyzer'],
      \     'filetypes': ['rust'],
      \     'project_root_files': ['Cargo.toml']
      \   }
      \ ]

      "}}}

      "" LSP Client Settings {{{

      " Configure LSP
      " https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua << EOF

-- nvim_lsp object
local nvim_lsp = require'nvim_lsp'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
    require'diagnostic'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    on_attach = on_attach
})
EOF
      " Trigger completion with <Tab>
      inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ completion#trigger_completion()
        
      function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~ '\s'
      endfunction


      " Code navigation shortcuts
      nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
      nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
      nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
      nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
      nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
      nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
      nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
      nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
      nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

      " Visualize diagnostics
      let g:diagnostic_enable_virtual_text = 1
      let g:diagnostic_trimmed_virtual_text = '40'
      " Don't show diagnostics while in insert mode
      let g:diagnostic_insert_delay = 1

      " Set updatetime for CursorHold
      " 300ms of no cursor movement to trigger CursorHold
      set updatetime=300
      " Show diagnostic popup on cursor hold
      autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()

      " Goto previous/next diagnostic warning/error
      nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
      nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

      " Enable type inlay hints
      autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
      \ lua require'lsp_extensions'.inlay_hints{ prefix = "", highlight = "Comment" }

      " have a fixed column for the diagnostics to appear in
      " this removes the jitter when warnings/errors flow in
      set signcolumn=yes
	
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

      "" Tex Settings {{{
      let g:vimtex_log_verbose = 1
      let g:livepreview_previewer = '${pkgs.okular}/bin/okular'
      "}}}

      "" Misc Settings {{{
      let g:rainbow_active = 1
      "}}}

    '' + optionalString isTexEnabled ''
      "" Tex Settings {{{
      let g:tex_flavor = 'latex'
      let g:livepreview_previewer = '${pkgs.okular}/bin/okular'
      "}}}
    '';
  };
}
