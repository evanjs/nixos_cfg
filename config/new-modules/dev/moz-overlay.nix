{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    (import "${(import ../../sources).nixpkgs-mozilla}/rust-overlay.nix")
  ];
}
