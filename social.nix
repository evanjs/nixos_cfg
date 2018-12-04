{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (slack.overrideAttrs (oldAttrs: { darkMode = true; }))
  ];
}
