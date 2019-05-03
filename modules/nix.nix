{ config, pkgs, options, ... }:
{

  environment.systemPackages = with pkgs; [
    nix-index
    nix-prefetch-scripts
  ];

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
