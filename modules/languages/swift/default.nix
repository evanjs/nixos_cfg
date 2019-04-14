{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    swift
  ];
}
