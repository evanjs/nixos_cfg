{ config, pkgs, lib, ... }:
with lib;
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
    config.mine.userConfig = mkIf config.mine.vim.enable {

      imports = [
      	../dev/moz-overlay.nix { config; }
        ./vim-home-manager.nix { colorscheme = config.mine.vim.colorscheme; }
      ];

    };
  }

