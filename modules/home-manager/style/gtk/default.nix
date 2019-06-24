{ config, pkgs, ... }:
{
  imports = [
    ./rounded-corners.nix
  ];
  gtk = {
    enable = true;
    iconTheme = {
      name = "Breeze-Dark";
      package = pkgs.breeze-icons;
    };
    theme = {
      name = "Breeze-Dark";
      package = pkgs.plasma5.breeze-gtk;
    };
  };
}
