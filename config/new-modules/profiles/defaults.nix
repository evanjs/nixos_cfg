{ options, config, lib, ... }:
with lib;
  {

    imports = [
      ../../../config
      ../../../overlays
      ../../../modules/home-manager
      ../../../modules/security/keybase.nix
      ../../../external/private
    ];

    mine.mainUsers = [ "root" ];

    nix.trustedUsers = [ "root" "@wheel" ];
    nixpkgs.config.allowUnfree = true;
    networking.networkmanager.enable = true;
    users.users.evanjs.extraGroups = [ "plugdev" "nginx" ];

    home-manager.useUserPackages = true;

  boot = {
    cleanTmpDir = true;
    loader.systemd-boot.memtest86.enable = true;
  };

    hardware.cpu.amd.updateMicrocode = true;
    hardware.cpu.intel.updateMicrocode = true;
  }
