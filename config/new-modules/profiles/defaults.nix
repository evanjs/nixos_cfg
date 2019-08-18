{ options, config, lib, ... }:
with lib;
{

  imports = [
    ../../../config
    ../../../overlays
    ../../../modules/home-manager
  ];

  mine.mainUsers = [ "root" ];

  nix.trustedUsers = [ "root" "@wheel" ];
  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  home-manager.useUserPackages = true;

  boot.cleanTmpDir = true;
}
