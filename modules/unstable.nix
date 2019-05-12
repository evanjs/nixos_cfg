{ config, pkgs, ... }:
{
  config.nixpkgs.config =
    {
    # Allow proprietary packages
    allowUnfree = true;

    # Create an alias for the unstable channel
    packageOverrides = pkgs:
    {
      stable = import (builtins.fetchTarball https://nixos.org/channels/nixos-19.03/nixexprs.tar.xz)
      #stable = import <stable>
      {
        # pass the nixpkgs config to the stable alias
        # to ensure `allowUnfree = true;` is propogated:
        config = config.nixpkgs.config;
      };

      unstable = import (builtins.fetchTarball https://nixos.org/channels/nixpkgs-unstable/nixexprs.tar.xz)
      #unstable = import <nixpkgs-unstable>
      {
        # pass the nixpkgs config to the unstable alias
        # to ensure `allowUnfree = true;` is propagated:
        config = config.nixpkgs.config;
      };
      unstable-small = import (builtins.fetchTarball https://nixos.org/channels/nixos-unstable-small/nixexprs.tar.xz)
      #unstable-small = import <nixos-unstable-small>
      {
        # pass the nixpkgs config to the unstable alias
        # to ensure `allowUnfree = true;` is propagated:
        config = config.nixpkgs.config;
      };
    };
  };
}
