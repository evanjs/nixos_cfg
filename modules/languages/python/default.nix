{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python37Full
    python37Packages.pillow
    python37Packages.setuptools
    pipenv
  ];
}
