{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    elm2nix
    elm-github-install
    elmPackages.elm
  ];
}
