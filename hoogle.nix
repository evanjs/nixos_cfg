{ config, pkgs, ... }:
{
  services = {
    hoogle = {
      enable = true;
      port = 8088;
    };
  };
}
