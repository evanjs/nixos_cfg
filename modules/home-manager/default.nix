{ config, pkgs, ... }:
{
  system.environmentPackages = with pkgs; [
    home-manager
  ];
}
