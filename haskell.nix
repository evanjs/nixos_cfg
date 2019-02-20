{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #haskellPackages.cabal-install
  ];
}
