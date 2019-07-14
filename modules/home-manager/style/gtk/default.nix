{ config, pkgs, ... }:
{
  imports = [
    ./rounded-corners.nix
  ];
  gtk = {
    enable = true;
    gtk2 = {
      extraConfig = ''
        gtk-application-prefer-dark-theme = true
      '';
    };

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
