{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python36Full
    python36Packages.pillow
    python36Packages.setuptools
    python37Full
    python37Packages.setuptools

  ];
}
