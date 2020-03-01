{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../config

    ../../../modules/db/postgresql.nix
    ../../../modules/development.nix
    ../../../modules/scrape.nix 
    #../../../modules/channels.nix
  ];

  mine.hardware = {
    battery = true;
    cpuCount = 8;
    swap = false;
    touchpad = true;
    wlan = true;
    audio = true;
  };

  services.xserver = {
    dpi = 127;
    displayManager.gdm.wayland = false;
  };


  fileSystems."/data/win" = {
    device = "/dev/disk/by-uuid/520C74190C73F677";
    fsType = "ntfs-3g";
  };

  mine.gaming.enable = true;

  system.autoUpgrade.enable = lib.mkForce false;

  mine.enableUser = true;
  mine.profiles.desktop.enable = true;

  networking.hostName = "nixentoo";

  boot.initrd.checkJournalingFS = false;
  powerManagement.powertop.enable = true;

  system.stateVersion = "19.09";
}
