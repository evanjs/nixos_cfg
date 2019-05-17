{ config, pkgs, ... }:
{
  imports = [
    ./tautulli.nix
  ];

  users.groups = { media = { }; };
  users.users.evanjs.extraGroups = [ "media" ];

  services.plex = {
    enable = true;
    openFirewall = true;
    managePlugins = false;
    group = "media";
  };
}
