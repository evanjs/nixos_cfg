{ config, pkgs, ... }:
{
  services = {
    kbfs = {
      enable = true;
    };
    keybase = {
      enable = true;
    };
  };
}
