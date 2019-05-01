{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ./custom-hardware.nix

    ../../modules/db/postgresql.nix
    ../../modules/development.nix
    #../../modules/steam.nix
    #../../modules/virtualization/virtualbox.nix
  ];

  networking.hostName = "nixentoo";

  system.stateVersion = "19.03";

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
