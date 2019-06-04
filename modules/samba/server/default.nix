{ config, ... }:
{
  imports = [
    ../default.nix
  ];

  networking.firewall = {
    allowPing = true;
  };
}
