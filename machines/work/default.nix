{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ./custom-hardware.nix

    ../../modules/android.nix
    ../../modules/db/postgresql.nix
    ../../modules/development.nix
    ../../modules/linux_latest.nix
    #../../modules/virtualization/virtualbox.nix # might re-enable after building / pushing to cachix from rig
  ];

  boot.initrd.checkJournalingFS = false;
  networking = {
    hostName = "nixjgtoo";
    # workaround for https://github.com/NixOS/nixpkgs/issues/61490
    nameservers = [
      "172.16.0.1"
    ];
  };

  system.stateVersion = "19.03";
}
