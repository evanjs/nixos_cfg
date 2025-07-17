{ config, pkgs, options, lib, ... }:
{
  imports = [
    ../services/autoPull.nix
  ];

  environment.systemPackages = with pkgs; [
    nix-index
    nix-prefetch-scripts
    nixpkgs-fmt
    nix-review
    patchelf
    niv
    # nix-du fails to build due to some tests during checkPhase
    #nix-du
  ];

  # Workaround for missing gz functionality in auto-upgrade packages
  # For more information, see https://github.com/NixOS/nixpkgs/issues/28527#issuecomment-325182680
  systemd.services.nixos-upgrade.path = with pkgs; [  gnutar xz.bin gzip config.nix.package.out ];

  system = {
    autoUpgrade = {
      channel = "nixos";
      dates = "00/6:00";
      enable = true;
    };
    copySystemConfiguration = true;
    extraSystemBuilderCmds = ''
      ln -sv ${../.} $out/nixcfg
    '';
  };

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = false;
      dates = "04:00";
    };

    extraOptions = ''
      min-free = ${toString (1024 * 1024 * 256)}
    '';
  };
}
