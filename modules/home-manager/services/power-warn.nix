{ pkgs, config, ... }:
{
  systemd.user.services.power-warn = {
    Unit = {
      Description = "Warns on low power level";
      WantedBy = [ "multi-user.target" ];
      After = [ "graphical.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.power-warn}/bin/power-warn";
    };
  };
}
