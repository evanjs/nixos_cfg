{ config, pkgs, ... }:
let
  sources = import ../../nix/sources.nix {};
  nixos-hardware = sources.nixos-hardware;
in
{
  imports = [
    ../nocam.nix
    ./wireless.nix
    (import "${nixos-hardware}/common/pc/laptop")
  ];
}
