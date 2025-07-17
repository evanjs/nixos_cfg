{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome3.vinagre
  ];
}
