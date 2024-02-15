{ config, lib, pkgs, ... }:
{
  imports = [
    ../nur.nix
  ];

  home-manager.users.evanjs = {
    programs.firefox = {
      enable = lib.mkDefault true;
      profiles = {
        mine = {
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            reddit-enhancement-suite
          ];
        };
      };
    };
  };
}
