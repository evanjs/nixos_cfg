{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.mine.obsidian;
in
  {
    options.mine.obsidian = {
      enable = mkEnableOption "Obsidian config";
    };

    config = mkIf cfg.enable {
      mine.xUserConfig = {
        programs.obsidian = {
          enable = lib.mkDefault false;
        };
      };
    };
  }
