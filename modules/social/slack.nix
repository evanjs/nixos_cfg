{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    slack-dark
    slack-term
  ];
}
