{ config, pkgs, ... }:
{
  imports = [
    ./arm.nix
    ./nixos.nix
    ./nixpkgs.nix
  ];

  environment.systemPackages = with pkgs; [
    cachix
  ];
}
