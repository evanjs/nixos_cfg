{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inkscape
    krita
    qt5.qtsvg
  ];
}
