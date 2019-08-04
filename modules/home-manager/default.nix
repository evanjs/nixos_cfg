{ config, pkgs, ... }:
{
  # Import home-manager for use as a NixOS submodule
  imports = [
    <home-manager/nixos>
    ./home.nix
  ];

  /* environment.systemPackages = with pkgs; [
    home-manager
  ]; */

  services.dbus.packages = with pkgs; [ gnome3.dconf ];
}
