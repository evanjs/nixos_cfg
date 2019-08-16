{ lib, config, pkgs, ... }:

with lib;

let

  cfg = config.mine.jetbrains;
in
  {
    options.mine.jetbrains = {
      enable = mkEnableOption "JetBrains programs";
      packages = mkOption {
        type = types.listOf types.package;
        # TODO: Option / switch for community/professional editions on all packages?
        default = [ pkgs.jetbrains.clion pkgs.jetbrains.idea-ultimate pkgs.jetbrains.webstorm pkgs.jetbrains.datagrip pkgs.jetbrains.pycharm-professional ];
        example = [ pkgs.jetbrains.phpstorm pkgs.jetbrains.pycharm-community ];
        description = "The JetBrains packages to install";
      };
    };

    config = mkIf cfg.enable {
      mine.userConfig = {
        home.packages = cfg.packages;
      };
    };
  }
