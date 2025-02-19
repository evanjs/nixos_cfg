{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../config
    
    ../../../modules/development.nix

    ../../../modules/db/postgresql.nix
    ../../../modules/samba/client/work.nix
  ];
  mine.hardware = {
    battery = false;
    cpuCount = 12;
    swap = false;
    touchpad = false;
    wlan = false;
    audio = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EB1D-0401";
    fsType = "vfat";
  };

  mine.enableUser = true;
  mine.profiles.desktop.enable = true;
  mine.emacs.enable = lib.mkForce false;
  mine.taffybar.enable = false;

  mine.android.enable = false;
  home-manager.users.evanjs.programs.mbsync.enable = false;
  home-manager.users.evanjs.services.mbsync.enable = false;

  # enable after rocm packages are locked to stable channel
  mine.rocm.enable = true;

  mine.virtualization.virtualbox.enable = false;
  boot.kernelPackages = lib.mkForce pkgs.stable.linuxPackages_latest;


  services.xserver.displayManager.gdm = {
    wayland = false;
  };
  
  systemd.targets."multi-user".conflicts = [ "getty@tty7.service" ];
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
  networking.hostName = "sekka";

  #services.tailscale.enable = true;

  boot.initrd.checkJournalingFS = false;

  home-manager.users.evanjs.home.stateVersion = "24.05";
  home-manager.users.root.home.stateVersion = "24.05";
  mine.userConfig.home.stateVersion = "24.05";
  mine.xUserConfig.home.stateVersion = "24.05";
  system.stateVersion = "19.09";
}
