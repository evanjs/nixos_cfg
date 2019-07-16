{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nerdfonts
  ];

  fonts = {
    fontconfig = {
      enable = true;
    };
  };
}
