{ pkgs, ... }:
{

  # uncomment when custom package for rbg is available system-wide
  environment.systemPackages = with pkgs; [
    feh
  ];

  systemd.user.timers.random-bg = {
    enable = true;
    wantedBy = [ "timers.target"];
    partOf = [ "random-bg.service" ];
    timerConfig.OnCalendar = "*:00:00";
  };

  systemd.user.services.random-bg = {
    wantedBy = [ "multi-user.target" ];
    after = [ "graphical.target" ];
    description = "Randomly sets the background image for all connected monitors.";
    serviceConfig = {
      Type = "oneshot";
      Environment="DISPLAY=:0";
      ExecStart = "/home/evanjs/.cargo/bin/rrbg";
    };
  };

}
