{ config, pkgs, ...}:
{
  services.xserver = {
    multitouch = {
      enable = true;
    };
  };
}
