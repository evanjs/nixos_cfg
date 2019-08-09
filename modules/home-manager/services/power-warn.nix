{ pkgs, config, ... }:
{
  home-manager.users.evanjs = {
    systemd.user.services.power-warn = {
      Unit = {
        Description = "Warns on low power level";
        After = [ "graphical.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.power-warn}/bin/power-warn";
      };

      Install = {
        WantedBy = [ "multi-user.target" ];
      };
    };
  };
}
