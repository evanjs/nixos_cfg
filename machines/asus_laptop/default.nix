{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ../../hardware/profiles/wireless.nix

    ../../modules/development.nix
    ../../modules/steam.nix
    ../../modules/virtualization.nix
  ];

  networking.hostName = "nixentoo";

  system.stateVersion = "19.03";

  boot.kernelPackages = pkgs.linuxPackages_4_19;
};
