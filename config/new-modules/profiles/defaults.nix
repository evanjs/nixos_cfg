{ options, config, lib, ... }:
with lib;
{

  imports = [
    ../../../config
    ../../../overlays
    ../../../modules/home-manager
    ../../../external/private
  ];

  mine.mainUsers = [ "root" ];

  nix.trustedUsers = [ "root" "@wheel" ];
  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;
  users.users.evanjs.extraGroups = [ "plugdev" ];

  home-manager.useUserPackages = true;

  boot.cleanTmpDir = true;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.cpu.intel.updateMicrocode = true;
}
