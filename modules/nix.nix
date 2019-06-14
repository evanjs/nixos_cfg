{ config, pkgs, options, lib, ... }:
{
  imports = [
    ./autoPull.nix
    ./cachix
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
      dates = "02:30";
      enable = true;
    };
    copySystemConfiguration = true;
  };

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "05:00";
    };
    binaryCaches = [
      "https://cache.nixos.org"
      "https://nixpkgs.cachix.org"
    ];
    trustedUsers = [ "root" "@wheel" ];
    binaryCachePublicKeys = [
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
    ];

    extraOptions = ''
      min-free = ${toString (1024 * 1024 * 1024)}
    '';

    nixPath =
      options.nix.nixPath.default ++
      [ "nixpkgs-overlays=/etc/nixos/modules/overlays-compat" ]
      ;
      #"/etc/nixos"
      #"nixpkgs=/etc/nixos"
      #"nixos-config=/etc/nixos/configuration.nix"
      #"/nix/var/nix/profiles/per-user/root/channels"
      #"nixpkgs-overlays=/overlays-compat/"
    };
  }
