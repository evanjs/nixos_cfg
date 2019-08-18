{ config, pkgs, ... }:
{
  imports = [
    ../nocam.nix
    ./wireless.nix
  ];
}
