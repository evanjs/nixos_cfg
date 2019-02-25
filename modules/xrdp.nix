  { config, pkgs, ... }:
  {
    services.xrdp = {
      enable = true;
      defaultWindowManager = "xmonad";
    };
    
    networking.firewall.allowedTCPPorts = [ 3389 ];
  }
