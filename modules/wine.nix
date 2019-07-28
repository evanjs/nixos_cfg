{ config, pkgs, ... }:
{
  imports = [
    ./channels.nix
  ];

  environment.systemPackages = with pkgs; [
    pkgs.stable.wine # opencv(?) fails to build on nightly
  ];
}
