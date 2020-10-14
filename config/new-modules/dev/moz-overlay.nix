{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    (import "${(import ../../nix/sources.nix {}).nixpkgs-mozilla}/rust-overlay.nix")
  ];
}
