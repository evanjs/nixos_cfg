{ config, pkgs, ... }:
{
  imports = [
    #./hoogle.nix
    #./hie.nix
  ];

  environment.systemPackages = with pkgs; [
    cabal-install
    #pkgs.stable.haskellPackages.jenkinsPlugins2nix
  ];
}
