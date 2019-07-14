{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    feh
    rrbg
  ];

  systemd.user.timers.random-bg = {
    enable = false;
    wantedBy = [ "timers.target"];
    partOf = [ "random-bg.service" ];
    timerConfig.OnCalendar = "*:*:00"; # hourly
  };

  systemd.user.services.random-bg = {
    wantedBy = [ "multi-user.target" ];
    after = [ "graphical.target" ];
    description = "Randomly sets the background image for all connected monitors.";
    serviceConfig = {
      Type = "oneshot";
      Environment="DISPLAY=:0";
      ExecStart = "${pkgs.rrbg}/bin/rrbg";
    };
  };

}
