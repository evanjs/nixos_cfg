{ config, pkgs, ... }:
{
  imports = [
    ./unstable.nix
  ];

  environment.systemPackages = with pkgs; [
    slack-dark
    discord
  ];
}
