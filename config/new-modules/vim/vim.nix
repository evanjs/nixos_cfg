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
    config.mine.userConfig = mkIf cfg.enable {

      imports = [
        nixvim.homeManagerModules.nixvim
        ../dev/rust-overlay.nix

        (import ./nixvim-hm.nix {
          inherit config pkgs lib;
          inherit (config.mine.userConfig) programs;
        })
      ];

    };
  }

