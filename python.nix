{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python36Packages.pillow
    python36Full
  ];
}
