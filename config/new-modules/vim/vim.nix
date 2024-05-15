{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.mine.vim;
  nixvim = import (builtins.fetchGit {
    #url = "https://github.com/nix-community/nixvim";
    #rev = "ffc5e7dc91ea5f47fae50c726c53a3dcb62d3e73";
    url = "https://github.com/traxys/nixvim";
    ref = "update_flake_compat";
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

