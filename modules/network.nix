{ config, pkgs, ... }:
{

  users.users.evanjs.extraGroups = [ "networkmanager" ];
  networking = {
    networkmanager = {
      enable = true;
    };
  };
}
