{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ./custom-hardware.nix

    ../../modules/db/postgresql.nix
    ../../modules/development.nix
    ../../modules/linux_latest.nix
    ../../modules/samba/client/home.nix
    ../../modules/unstable.nix
    ../../modules/steam.nix
    ../../modules/virtualization/virtualbox.nix
  ];

  services.xserver.dpi = 127;
  
  boot.initrd.checkJournalingFS = false;
  networking = {
    hostName = "nixentoo";
    # workaround for https://github.com/NixOS/nixpkgs/issues/61490
    nameservers = [
      "172.16.0.1"
      "10.10.0.1"
      "192.168.2.1"
    ];
  };

  system.stateVersion = "19.03";
}
