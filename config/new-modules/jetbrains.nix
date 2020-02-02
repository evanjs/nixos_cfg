{ lib, config, pkgs, ... }:

with lib;

let

  cfg = config.mine.jetbrains;
  getNewestFromChannels = name:
    pkgs.versions.latestVersion
    ((_: map (channel: (lib.getAttr name channel.jetbrains)) channels) name);
  # TODO: Make this depend on the channels module, etc.?
  channels = [
    pkgs
    pkgs.nixpkgs-unstable
    pkgs.nixos-unstable
    pkgs.nixos-unstable-small
  ];
in {
  options.mine.jetbrains = {
    enable = mkEnableOption "JetBrains programs";
    packages = mkOption {
      type = types.listOf types.str;
      # TODO: Option / switch for community/professional editions on all packages?
      default = [
        "clion"
        "idea-ultimate"
        "webstorm"
        "datagrip"
        "pycharm-professional"
      ];
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
        default = 63341;
        example = 63342;
        description = ''
          The port to use to connect to the IDE.
          The default port that is used by JetBrains is 63342.
          External connections can be enabled in the IDE by enabling "Can accept external connections".
          Note that, in order to enable this option, the port must be a non-default port, e.g. 8080, 63341, etc.
        '';
      };
      openFirewall = mkOption {
        type = types.bool;
        default = true;
        example = false;
        description =
          "Open ports in the firewall for JetBrains IDE support.  This is required for remote debugging.";
      };
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts =
      if cfg.ideSupport.enable then [ cfg.ideSupport.port ] else [ ];

    mine.userConfig = {
      home.packages = if cfg.useLatest then
        lists.map getNewestFromChannels cfg.packages
      else
        cfg.packages;
    };
  };
}
