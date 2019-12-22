{ config, pkgs, libs, ... }:
{
  services.minecraft-server = {
    enable = false;
    eula = true;
    openFirewall = true;
  };
}
