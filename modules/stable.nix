{ config, pkgs, ... }:
{
  config.nixpkgs.config =
    {
    # Allow proprietary packages
    allowUnfree = true;

    # Create an alias for the unstable channel
    packageOverrides = pkgs:
    { 
      stable = import <nixos-stable>
      {
        # pass the nixpkgs config to the unstable alias
        # to ensure `allowUnfree = true;` is propagated:
        config = config.nixpkgs.config;
      };
    };
  };
}
