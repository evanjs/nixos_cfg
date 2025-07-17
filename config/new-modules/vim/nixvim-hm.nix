{ config, pkgs, lib, programs, ... }:
with lib;
let
  helpers = lib.nixvim;
in
{

  imports = [
    ./options.nix
    ./plugins/airline.nix
    ./plugins/lsp.nix
    ./plugins/rust.nix
    ./plugins/tagbar.nix
    #./plugins/tex.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    #package = pkgs.neovim-nightly;
    #colorscheme = config.mine.vim.colorscheme;
    colorschemes.ayu.enable = true;
    defaultEditor = true;
    extraPlugins = with pkgs.vimPlugins; [
      vim-autoformat
      nerdcommenter
    ]
    ++
    config.mine.vim.extraPlugins;

    extraConfigVim = ''
      if has('persistent_undo')
        set undofile
        set undodir=$HOME/.local/share/nvim/undo
      endif
    '';

    plugins = {

      #comment-nvim.enable = true;
      fugitive.enable = true;
      illuminate.enable = true;
      #image.enable = true;
      rainbow-delimiters.enable = true;
      treesitter.enable = true;
      lastplace.enable = true;
      nix.enable = true;
      neogit = {
        enable = true;
        ##plugins = [
        ##  "diffview"
        ##];
      };

      ## TODO: nvim-cmp

      nvim-colorizer.enable = true;
    };
  };

  #programs.neovim = {
    #enable = true;
    #package = pkgs.neovim-nightly;

    #viAlias = true;
    #vimAlias = true;
    #withPython3 = true;
    #withNodeJs = true;
  #};
}
