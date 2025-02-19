{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{

  config.nixpkgs.config = {
    # Allow proprietary packages
    allowUnfree = true;

    # Create an alias for the unstable channel
    packageOverrides = pkgs: rec {
      stable = import (fetchTarball "https://nixos.org/channels/nixos-24.11/nixexprs.tar.xz") {
        #stable = import <nixos-24.11> {
        config = config.nixpkgs.config;
      };
      nixos-unstable = import (fetchTarball "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz") {
        #nixos-unstable = import <nixos-unstable> {
        # pass the nixpkgs config to the unstable alias
        # to ensure `allowUnfree = true;` is propagated:
        config = config.nixpkgs.config;
      };

      nixpkgs-unstable =
        import (fetchTarball "https://github.com/nixos/nixpkgs-channels/archive/nixpkgs-unstable.tar.gz")
          {
            #nixpkgs-unstable = import <nixpkgs-unstable> {
            # pass the nixpkgs config to the unstable alias
            # to ensure `allowUnfree = true;` is propagated:
            config = config.nixpkgs.config;
          };
      nixos-unstable-small =
        import (fetchTarball "https://nixos.org/channels/nixos-unstable-small/nixexprs.tar.xz")
          {
            #nixos-unstable-small = import <nixos-unstable-small> {
            # pass the nixpkgs config to the unstable alias
            # to ensure `allowUnfree = true;` is propagated:
            config = config.nixpkgs.config;
          };
    };
  };
}
