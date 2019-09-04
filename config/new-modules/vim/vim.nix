{ config, pkgs, lib, ... }:
with lib;

let

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
        withPython3 = true;

        plugins = with pkgs.vimPlugins; [
          fugitive
          ghc-mod-vim
          haskell-vim
          LanguageClient-neovim
          nerdcommenter
          neomake
          polyglot
          ranger-vim
          rust-vim
          SpaceCamp
          syntastic
          vim-airline
          vim-airline-themes
          vim-autoformat
          YouCompleteMe
        ];
      };
    };
  }

