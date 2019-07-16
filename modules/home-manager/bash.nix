{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    powerline-go
  ];
}
