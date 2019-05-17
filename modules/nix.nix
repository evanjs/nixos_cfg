{ config, pkgs, options, lib, ... }:
{

  environment.systemPackages = with pkgs; [
    cachix
    nix-index
    nix-prefetch-scripts
  ];

  system = {
    autoUpgrade = {
      channel = "https://nixos.org/channels/nixos-unstable";

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
