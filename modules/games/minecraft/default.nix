{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    multimc
    mcdex
  ];
}
