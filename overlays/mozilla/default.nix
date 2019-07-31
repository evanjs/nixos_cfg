{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (import ./nixpkgs-mozilla/rust-overlay.nix)
  ];
}
