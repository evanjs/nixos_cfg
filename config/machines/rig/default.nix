{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../config

    ../../../modules/development.nix

    # media
    ../../../modules/deluge.nix
    ../../../modules/plex

    ../../../modules/jupyter
    
    ../../../modules/scrape.nix
    ../../../modules/virtualization/docker.nix
    ../../../modules/virtualization/virtualbox.nix

    ../../../modules/samba/server/home.nix
  ];

  mine.hardware = {
    battery = false;
    cpuCount = 8;
    swap = false;
    touchpad = false;
    wlan = true;
    audio = true;
  };

  mine.enableUser = true;
  mine.profiles.desktop.enable = true;
  mine.gaming.enable = true;
  mine.znc.enable = true;

  services.xserver.dpi = 80;

  boot.crashDump = {
    enable = true;
  };

  boot.initrd.checkJournalingFS = false;
  networking.hostName = "nixtoo";
  system.stateVersion = "19.03";
}
