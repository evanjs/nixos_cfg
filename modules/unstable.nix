{ config, pkgs, ... }:
{
  config.nixpkgs.config =
    {
    # Allow proprietary packages
    allowUnfree = true;

    # Create an alias for the unstable channel
    packageOverrides = pkgs:
    {
      stable = import <stable>
      {
        # pass the nixpkgs config to the stable alias
        # to ensure `allowUnfree = true;` is propogated:
        config = config.nixpkgs.config;
      };

      unstable = import <nixos-unstable-small>
      {
        # pass the nixpkgs config to the unstable alias
        # to ensure `allowUnfree = true;` is propagated:
        config = config.nixpkgs.config;
      };
      unstable-small = import <nixos-unstable-small>
      {
        # pass the nixpkgs config to the unstable alias
        # to ensure `allowUnfree = true;` is propagated:
        config = config.nixpkgs.config;
      };
    };
  };
}
