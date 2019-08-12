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

      configure = {
        #customRC = (toString (toString (builtins.attrValues (pkgs.nix-helpers.importFrom ./config))));
        vam = {
          knownPlugins = pkgs.vimPlugins;
          pluginDictionaries =
            [
              { name = "fugitive"; }
              { name = "ghc-mod-vim"; }
              { name = "haskell-vim"; }
              { name  = "LanguageClient-neovim"; }
              { name = "nerdcommenter"; }
              { name = "neomake"; }
              { name = "polyglot"; }
              { name = "ranger-vim"; }
              { name = "rust-vim"; }
              { name = "SpaceCamp"; }
              { name = "syntastic"; }
              { name = "vim-airline"; }
              { name = "vim-airline-themes"; }
              { name = "vim-autoformat"; }
              { name  =  "YouCompleteMe"; }
            ];
          };
        };
      };
    };
  }

