{ config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../config

    # games
    #../../../modules/games/steam.nix

    ../../../modules/db/postgresql.nix
    ../../../modules/development.nix
    ../../../modules/samba/client/home.nix
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

  mine.enableUser = true;
  mine.profiles.desktop.enable = true;

  mine.compton.nvidia = true;

  networking.hostName = "nixentoo";

  boot.initrd.checkJournalingFS = false;
  powerManagement.powertop.enable = true;

  system.stateVersion = "19.03";
}
