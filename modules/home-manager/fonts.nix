{ config, pkgs, lib, ... }:
{
  home-manager.users.evanjs = {
    fonts = {
      fontconfig = {
        enable = lib.mkForce true;
      };
    };
    home.packages = with pkgs; [
      nerdfonts
      #powerline-fonts
    ];
  };
}
