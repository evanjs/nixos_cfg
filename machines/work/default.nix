{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ./custom-hardware.nix

    ../../modules/android.nix
    ../../modules/db/postgresql.nix
    ../../modules/development.nix
    ../../modules/linux_latest.nix
    #../../modules/virtualization/virtualbox.nix # might re-enable after building / pushing to cachix from rig
  ];

  networking.hostName = "nixjgtoo";

  system.stateVersion = "19.03";
}
