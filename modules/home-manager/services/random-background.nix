{ pkgs, ... }:
{
  home-manager.users.evanjs = {
    home.packages = [ pkgs.rrbg ];
    systemd.user.timers.random-background = {
      Unit = {
        PartOf = [ "random-bg.service" ];
        Description = "Starts the random background switcher service";
      };

      Timer = {
        OnCalendar = "*:30:00"; # every 30 minutes
      };

      Install = {
        WantedBy = [ "timers.target"];
      };
    };

    systemd.user.services.random-background = {
      Unit = {
        After = [ "graphical.target" ];
        Description = "Randomly sets the background image for all connected monitors.";
      };

      Service = {
        Type = "oneshot";
        Environment="DISPLAY=:0";
        ExecStart = "${pkgs.rrbg}/bin/rrbg";
      };
      
      Install = {
        WantedBy = [ "multi-user.target" ];
      };

    };
  };
}
