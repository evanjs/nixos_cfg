{ config, pkgs, ... }:
{
  imports = [
    ./arm.nix
    ./nixos.nix
    ./nixpkgs.nix
    ./taffy.nix
  ];

  environment.systemPackages = with pkgs; [
    cachix
  ];
}
