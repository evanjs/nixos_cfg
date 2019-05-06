{ config, pkgs, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
    };
  };

  users.users.evanjs.extraGroups = [ "docker" ];
}
