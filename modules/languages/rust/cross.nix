{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;

  users.extraUsers.evanjs.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    cross
  ];
}
