{ config, pkgs, options, lib, ... }:
{
  imports = [
    ../services/autoPull.nix
  ];

  environment.systemPackages = with pkgs; [
    nix-index
    nix-prefetch-scripts
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
  };

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "04:00";
    };

    extraOptions = ''
      min-free = ${toString (1024 * 1024 * 1024)}
    '';

    nixPath =
      options.nix.nixPath.default ++
      [ "nixpkgs-overlays=/etc/nixos/modules/overlays-compat" ]
      ;
    };

    system.extraSystemBuilderCmds = ''
      ln -sv ${../.} $out/nixcfg
    '';
  }
