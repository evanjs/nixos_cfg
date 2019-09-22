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
    description = "Synchronizes the local nixos_cfg with upstream";

    path = with pkgs; [
      git
    ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.git}/bin/git pull";

      # Can we detect this somehow?
      # i.e. where is the currently used nixos_cfg directory located?
      WorkingDirectory = "/etc/nixos";
    };
  };

}
