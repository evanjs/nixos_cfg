{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable Tailscale for internal routing
  services.tailscale = {
    enable = true;
    #magicDNS = true;
  };

  # Configure Tailscale MagicDNS
  systemd.services.tailscaled = {
    environment = {
      TS_MAGICDNS = "true";
    };
    #extraConfig = ''
    #[DNS]
    #MagicDNS = true
    #'';
  };
}
