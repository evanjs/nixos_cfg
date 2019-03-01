{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mdbook
  ];
}
