{ config, pkgs, ... }:
{
  imports = [
    ./ui.nix
  ];

  environment.systemPackages = with pkgs; [
    python37Full
    python37Packages.pillow
    python37Packages.setuptools

  ];
}
