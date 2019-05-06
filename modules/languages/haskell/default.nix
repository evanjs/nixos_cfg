{ config, pkgs, ... }:
{
  imports = [
    ./hie.nix
    ./hoogle.nix
  ];

  environment.systemPackages = with pkgs; [
    cabal-install
    #pkgs.stable.haskellPackages.jenkinsPlugins2nix
  ];
}
