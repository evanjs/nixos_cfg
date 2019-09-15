{ config, pkgs, ... }:
{
  imports = [
    ../nocam.nix
    ./wireless.nix
    (import "${(import ../../sources).nixos-hardware}/common/pc/laptop")
  ];
}
