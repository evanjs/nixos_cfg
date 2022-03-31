{ options, config, lib, ... }:
with lib; {

  imports = [
    ../../../overlays
    ../../../modules/home-manager
    ../../../modules/security/keybase.nix
    ../../../external/private
    "${(import ../../nix/sources.nix).sops-nix}/modules/sops"
  ];

  mine.mainUsers = [ "root" ];

  nix.trustedUsers = [ "root" "@wheel" ];
  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = lib.mkDefault true;
  users.users.evanjs.extraGroups = [ "plugdev" "nginx" ];

  home-manager.useUserPackages = true;

  boot = { cleanTmpDir = true; };

  hardware.cpu.amd.updateMicrocode = true;
  hardware.cpu.intel.updateMicrocode = true;
}
