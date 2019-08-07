{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (import ./nix-helpers/overlay.nix)
  ];
}
