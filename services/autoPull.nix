{ pkgs, config, ... }:
{
  systemd.user.timers.autoPullNixCfg = {
    enable = true;
    wantedBy = [ "timers.target"];
    partOf = [ "autoPullNixCfg.service" ];
    timerConfig.OnCalendar = "*-*-* *:00:00"; # hourly
  };

  systemd.user.services.autoPullNixCfg = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Synchronizes the local nixos configuration with upstream";

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.git}/bin/git pull";

      # Can we detect this somehow?
      # i.e. where is the nixos configuration directory located?
      WorkingDirectory = "/etc/nixos";
    };
  };

}
