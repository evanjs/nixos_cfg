{ lib, config, pkgs, ... }:

with lib;

let

  cfg = config.mine.jetbrains;
  getNewestFromChannels = name: pkgs.versions.latestVersion ((_: map (channel: (lib.getAttr name channel.jetbrains)) channels) name);
  # TODO: Make this depend on the channels module, etc.?
  channels = [ pkgs pkgs.stable pkgs.unstable pkgs.unstable-small ];
in
  {
    options.mine.jetbrains = {
      enable = mkEnableOption "JetBrains programs";
      packages = mkOption {
        type = types.listOf types.str;
        # TODO: Option / switch for community/professional editions on all packages?
        default = [ "clion" "idea-ultimate" "webstorm" "datagrip" "pycharm-professional" ];
        example = [ "phpstorm" "pycharm-community" ];
        description = "The JetBrains packages to install";
      };
      useLatest = mkEnableOption "using latest JetBrains programs";
    };

    config = mkIf cfg.enable {
      mine.userConfig = {
        home.packages =
          if cfg.useLatest 
          then lists.map getNewestFromChannels cfg.packages
          else cfg.packages;
      };
    };
  }
