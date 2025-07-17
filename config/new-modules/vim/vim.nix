{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.mine.vim;
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "main";
  });
in
  {
    imports = [
      nixvim.nixosModules.nixvim
    ];
    options.mine.vim = {
      colorscheme = mkOption {
        type = types.str;
        default = "";
        example = "nord";
        description = "The colorscheme to use for vim.";
      };
      enable = mkEnableOption "vim config";
      extraPlugins = mkOption {
        type = types.listOf types.package;
        default = [];
        example = ''
          with pkgs.vimPlugins; [
            nord-vim
          ]
        '';
        description = "Additional plugins to add to the vim configuration";
      };
    };
    config.mine.userConfig = mkIf cfg.enable rec {
      imports = [
        nixvim.homeManagerModules.nixvim

        (import ./nixvim-hm.nix {
          inherit config pkgs lib nixvim;
          inherit (config.mine.userConfig) programs;
        })
      ];

    };
  }

