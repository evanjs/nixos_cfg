{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Open Firewall Ports
  networking.firewall.allowedTCPPorts = [
    18080
  ];
}
