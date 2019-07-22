{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nerdfonts
    powerline-fonts
  ];

  fonts = {
    fontconfig = {
      enable = true;
    };
  };
}
