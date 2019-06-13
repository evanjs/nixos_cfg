{ config, pkgs, ... }:
{
  imports = [
    ./custom-hardware.nix
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ../../hardware/profiles/wireless.nix

    ../../modules/development.nix
    ../../modules/linux_latest.nix

    # games
    ../../modules/games/steam.nix

    # media
    ../../modules/deluge.nix
    ../../modules/plex
    
    ../../modules/scrape.nix
    ../../modules/virtualization/docker.nix
    ../../modules/samba/server/home.nix
  ];

  boot.initrd.checkJournalingFS = false;
  networking = {
    hostName = "nixtoo";
    # workaround for https://github.com/NixOS/nixpkgs/issues/61490
    nameservers = [
      "10.10.0.1"
    ];
  };

  system.stateVersion = "19.03";
}
