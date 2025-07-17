{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pkgs.gnome-connections
  ];
}
