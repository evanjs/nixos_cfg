{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ../../hardware/profiles/wireless.nix

    ../../modules/development.nix
  ];

  #nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixjgtoo";

  system.stateVersion = "19.03";

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
