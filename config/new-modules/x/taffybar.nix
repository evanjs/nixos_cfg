{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.mine.taffybar;
in {

  options.mine.taffybar = {
    enable = mkEnableOption "taffybar config";
    package = mkOption {
      description = "The taffybar package to use";
      default = (import ./taffybar { inherit pkgs; }).mytaffybar;
      example = pkgs.taffybar;
    };
  };

  config = mkIf cfg.enable {

    services.upower.enable = true;

    mine.userConfig = {
      systemd.user.services.taffybar = {
        Unit = {
          Description = "Taffybar";
          After = [ "graphical-session-pre.target" ];
          PartOf = [ "graphical-session.target" ];
        };

        Service = {
          ExecStart = "${cfg.package}/bin/mytaffybar";
          Restart = "on-failure";
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
      gtk.iconTheme = {
        name = "hicolor";
        package = pkgs.hicolor-icon-theme;
      };
    };
  };
}
