{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
    ./custom-hardware.nix

    ../../modules/db/postgresql.nix
    ../../modules/development.nix
    #../../modules/steam.nix
    ../../modules/unstable.nix
    ../../modules/virtualization/virtualbox.nix
  ];

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

  boot.kernelPackages = pkgs.unstable.linuxPackages_latest;
}
