{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pkgs.wine # opencv(?) fails to build on nightly
  ];
}
