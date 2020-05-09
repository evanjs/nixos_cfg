{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix


    ../../../config
    
    ../../../modules/development.nix

    ../../../modules/android.nix
    ../../../modules/db/postgresql.nix
    ../../../modules/samba/client/work.nix
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
  mine.virtualization.virtualbox.enable = false;

  networking.hostName = "nixjgtoo";

  boot.initrd.checkJournalingFS = false;

  system.stateVersion = "19.09";
}
