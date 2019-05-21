{ config, pkgs, ... }:
{
  imports = [
    ./custom-hardware.nix
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ../../hardware/profiles/wireless.nix

    ../../modules/development.nix
    ../../modules/linux_latest.nix

    # media
    ../../modules/deluge.nix
    ../../modules/plex
    
    ../../modules/scrape.nix
    ../../modules/virtualization/docker.nix
  ];

  boot.initrd.checkJournalingFS = false;
  networking.hostName = "nixtoo";

  system.stateVersion = "19.03";
}
