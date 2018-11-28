{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bat
  ];
}
