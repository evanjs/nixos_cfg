{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../external/home-manager/nixos

    ../../../config
    #../../../modules/home-manager

    ../../../external/home-manager/nixos
    # games
    #../../../modules/games/steam.nix

    ../../../modules/db/postgresql.nix
    ../../../modules/development.nix
    ../../../modules/linux_latest.nix
    ../../../modules/samba/client/home.nix
    #../../../modules/channels.nix
    #../../../modules/virtualization/virtualbox.nix
  ];

  mine.hardware = {
    battery = true;
    cpuCount = 8;
    swap = false;
    touchpad = true;
    wlan = true;
    audio = true;
  };

  services.xserver.displayManager.gdm.wayland = false;

  mine.enableUser = true;
  mine.profiles.desktop.enable = true;

  mine.compton.nvidia = true;

  networking.hostName = "nixentoo";

  boot.initrd.checkJournalingFS = false;
  powerManagement.powertop.enable = true;

  system.stateVersion = "19.03";
}
