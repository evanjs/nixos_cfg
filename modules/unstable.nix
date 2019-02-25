{ config, pkgs, ... }:
{
  config.nixpkgs.config =
    {
    # Allow proprietary packages
    allowUnfree = true;

    # Create an alias for the unstable channel
    packageOverrides = pkgs:
    {
      unstable = import <nixpkgs-unstable>
      {
        # pass the nixpkgs config to the unstable alias
        # to ensure `allowUnfree = true;` is propagated:
        config = config.nixpkgs.config;
      };
      # error: infinite recursion detected
      # caused by overlays (?)      
      #unstable-small = import <nixos-unstable-small>
      #{
        ## pass the nixpkgs config to the unstable alias
        ## to ensure `allowUnfree = true;` is propagated:
        #config = config.nixpkgs.config;
      #};
    };
  };
}
