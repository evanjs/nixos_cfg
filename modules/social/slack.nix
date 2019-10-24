{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ( pkgs.versions.latestVersion [ pkgs.slack-dark pkgs.nixos-unstable.slack-dark pkgs.nixos-unstable-small.slack-dark ] )
    ( pkgs.versions.latestVersion [ pkgs.slack-term pkgs.nixos-unstable.slack-term pkgs.nixos-unstable-small.slack-term ] )
  ];
}
