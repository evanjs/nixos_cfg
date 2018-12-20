{ config, pkgs, ... }:
{
  imports = [
    ./random-bg.nix
    ./rustup.nix
  ];
}
