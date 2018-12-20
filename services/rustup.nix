{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    rustup
  ];

  systemd.user.timers.rustupup = {
    enable = true;
    wantedBy = [ "timers.target"];
    partOf = [ "rustupup.service" ];
    timerConfig.OnCalendar = "*-*-* 12:00:00";
  };

  systemd.user.services.rustupup = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Updates the installed Rust toolchains via `rustup update`";
    serviceConfig = {
      Type = "simple";
      ExecStart = "rustup update";
    };
  };

}
