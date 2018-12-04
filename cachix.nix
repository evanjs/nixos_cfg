{ config, pkgs, ... }:
{
  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://nixpkgs.cachix.org"
    ];
    binaryCachePublicKeys = [
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
      ];
      trustedUsers = [ "root" "evanjs" ];
    };
  }
