{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python37Full
    python38Full
    python37Packages.pillow
    python37Packages.setuptools
    pipenv
  ];
}
