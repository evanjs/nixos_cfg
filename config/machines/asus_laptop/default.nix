{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../config

    ../../../modules/db/postgresql.nix
    ../../../modules/development.nix
    ../../../modules/scrape.nix 
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


  mine.gaming.enable = true;

  mine.enableUser = true;
  mine.profiles.desktop.enable = true;

  networking.hostName = "nixentoo";

  boot.initrd.checkJournalingFS = false;
  powerManagement.powertop.enable = true;

  system.autoUpgrade.enable = lib.mkForce false;

  system.stateVersion = "19.09";
}
