{ config, pkgs, ... }:
let
  sources = import ../../config/nix/sources.nix {};
  nurNoPkgs = import sources.nur {};
in
  {
  # Import home-manager for use as a NixOS submodule
  imports = [
    nurNoPkgs.repos.rycee.modules.home-manager
    ./home.nix
  ];

  services.dbus.packages = with pkgs; [ dconf ];
}
