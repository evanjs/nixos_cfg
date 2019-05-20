{ config, pkgs, ... }:
{
  imports = [
    ./hie.nix
    ./hoogle.nix
    ../../unstable.nix
  ];

  environment.systemPackages = with pkgs; [
    cabal-install
    pkgs.unstable-small.cabal2nix

    #pkgs.stable.haskellPackages.jenkinsPlugins2nix
  ];
}
