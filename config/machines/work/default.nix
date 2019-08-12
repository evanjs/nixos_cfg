{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    #./config/external/home-manager/nixos
    ../../../config
    ../../../modules/home-manager

    ../../../modules/android.nix
    ../../../modules/db/postgresql.nix
    ../../../modules/development.nix
    ../../../modules/linux_latest.nix
    ../../../modules/samba/client/work.nix
    #../../../modules/virtualization/virtualbox.nix # might re-enable after building / pushing to cachix from rig
  ];
  mine.hardware = {
    battery = true;
    cpuCount = 4;
    swap = false;
    touchpad = true;
    wlan = true;
    audio = true;
  };

  mine.enableUser = true;
  mine.profiles.desktop.enable = true;

  networking.hostName = "nixjgtoo";

  boot.initrd.checkJournalingFS = false;

  system.stateVersion = "19.03";
}
