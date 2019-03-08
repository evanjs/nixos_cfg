{ pkgs, ... }:
{
  imports = [
    ./cachix.nix
  ];

  environment.systemPackages = with pkgs; [
    hies
  ];
}
