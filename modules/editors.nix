{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    atom
    bat
  ];
}
