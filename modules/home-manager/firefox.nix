{ config, pkgs, ... }:
{
  imports = [
    ../nur.nix
  ];

  programs.firefox = {
    enable = true;
    enableAdobeFlash = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      https-everywhere
      ublock-origin
      #_1password
    ];
  };
}
