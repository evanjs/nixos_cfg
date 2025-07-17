{ config, lib, pkgs, ... }:
{
  imports = [
    ../nur.nix
  ];

  home-manager.users.evanjs = {
    programs.firefox = {
      enable = lib.mkDefault true;
      profiles.default.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
      #https-everywhere
      ublock-origin
      reddit-enhancement-suite
      ];
    };
  };
}
