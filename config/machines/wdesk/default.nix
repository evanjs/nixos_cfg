{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../config
    
    ../../../modules/development.nix

    ../../../modules/db/postgresql.nix
    #../../../modules/samba/client/work.nix
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
  mine.tex.enable = true;

  mine.android.enable = true;

  # enable after rocm packages are locked to stable channel
  mine.rocm.enable = false;

  mine.jetbrains.enable = false;

  mine.virtualization.virtualbox.enable = false;
  boot.kernelPackages = lib.mkForce pkgs.stable.linuxPackages_latest;

  networking.hostName = "sekka";

  system.rebuild.enableNg = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraSetFlags = [
      "--accept-routes"
    ];
  };

  boot.initrd.checkJournalingFS = false;

  system.stateVersion = "19.09";
}
