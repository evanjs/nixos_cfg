{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    virtualgl
  ];

  users.users.evanjs.extraGroups = [ "vglusers" ];
}

