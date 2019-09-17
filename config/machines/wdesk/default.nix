{ config, pkgs, lib, ... }:
let
  nurNoPkgs = import (import ../../sources).nur {};
in
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../external/home-manager/nixos



    ../../../config
    
    ../../../modules/development.nix

    ../../../modules/android.nix
    ../../../modules/db/postgresql.nix
    ../../../modules/samba/client/work.nix
    ../../../modules/virtualization/virtualbox.nix # might re-enable after building / pushing to cachix from rig
  ];
  mine.hardware = {
    battery = false;
    cpuCount = 12;
    swap = false;
    touchpad = false;
    wlan = false;
    audio = true;
  };

  mine.enableUser = true;
  mine.profiles.desktop.enable = true;

  networking.hostName = "nixjgtoo";

  boot.initrd.checkJournalingFS = false;

  system.stateVersion = "19.03";
}
