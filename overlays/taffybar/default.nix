{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (import ./taffybar/overlay.nix)
  ];
}
