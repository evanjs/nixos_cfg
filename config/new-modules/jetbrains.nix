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
      ideSupport = {
        enable = mkOption {
          type = types.bool;
          default = true;
          example = false;
          description = "JetBrains IDE Support for Chrome-based browsers";
        };
        port = mkOption {
          type = types.int;
          default = 63342;
          example = 8080;
          description = "The port to use to connect to the IDE";
        };
        openFirewall = mkOption {
          type = types.bool;
          default = true;
          example = false;
          description = "Open ports in the firewall for JetBrains IDE support.  This is required for remote debugging.";
        };
      };
    };

    config = mkIf cfg.enable {
      networking.firewall.allowedTCPPorts =
        if cfg.ideSupport.enable
        then [ cfg.ideSupport.port ]
        else [];

        mine.userConfig = {
          home.packages =
            if cfg.useLatest
            then lists.map getNewestFromChannels cfg.packages
            else cfg.packages;
          };
        };
      }
