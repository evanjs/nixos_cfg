{ config, pkgs, lib, ... }:
with lib; {

  config.nixpkgs.config = {
    # Allow proprietary packages
    allowUnfree = true;

    # Create an alias for the unstable channel
    packageOverrides = pkgs: rec {

      stable = import (fetchTarball
        "https://nixos.org/channels/nixos-19.09/nixexprs.tar.xz") {
          config = config.nixpkgs.config;
        };
      nixos-unstable = import (fetchTarball
        "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz") {
          # pass the nixpkgs config to the unstable alias
          # to ensure `allowUnfree = true;` is propagated:
          config = config.nixpkgs.config;
        };

      nixpkgs-unstable = import (fetchTarball
        "https://github.com/nixos/nixpkgs-channels/archive/nixpkgs-unstable.tar.gz") {
          # pass the nixpkgs config to the unstable alias
          # to ensure `allowUnfree = true;` is propagated:
          config = config.nixpkgs.config;
        };
      nixos-unstable-small = import (fetchTarball
        "https://nixos.org/channels/nixos-unstable-small/nixexprs.tar.xz") {
          # pass the nixpkgs config to the unstable alias
          # to ensure `allowUnfree = true;` is propagated:
          config = config.nixpkgs.config;
        };
    };
  };
}
