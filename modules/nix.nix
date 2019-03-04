{ config, pkgs, options, ... }:
{

  environment.systemPackages = with pkgs; [
    nix-index
    nix-prefetch-scripts
  ];


  nix = {
    binaryCaches = [
      "https://cache.nixos.org"
    ];
    trustedUsers = [ "root" "@wheel" ];
    binaryCachePublicKeys = [
    ];

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
