{ config, pkgs, ... }:
let
  nurNoPkgs = import (import ../../config/sources).nur {};
in
  {
  # Import home-manager for use as a NixOS submodule
  imports = [
    nurNoPkgs.repos.rycee.modules.home-manager
    ./home.nix
  ];

  services.dbus.packages = with pkgs; [ gnome3.dconf ];
}
