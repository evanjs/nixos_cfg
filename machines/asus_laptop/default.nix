{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ./custom-hardware.nix

    # games
    ../../modules/games/steam.nix

    ../../modules/db/postgresql.nix
    ../../modules/development.nix
    ../../modules/linux_latest.nix
    ../../modules/samba/client/home.nix
    ../../modules/unstable.nix
    ../../modules/virtualization/virtualbox.nix
  ];

  services.xserver = {
    desktopManager.xterm.enable = false;
    dpi = 127;
    displayManager = {
      gdm = {
        wayland = false;
      };
    };
  };

  boot.initrd.checkJournalingFS = false;
  networking = {
    hostName = "nixentoo";
  };
  powerManagement.powertop.enable = true;

  system.stateVersion = "19.03";
}
