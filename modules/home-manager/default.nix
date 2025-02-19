{ config, pkgs, ... }:
let
  sources = import ../../config/nix/sources.nix {};
  home-manager = import sources.home-manager {};
in
  {
  # Import home-manager for use as a NixOS submodule
  imports = [
    <home-manager/nixos>
    ./home.nix
  ];

  services.dbus.packages = with pkgs; [ dconf ];
}
