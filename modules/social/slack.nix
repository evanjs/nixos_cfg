{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ( pkgs.versions.latestVersion [ pkgs.slack pkgs.nixos-unstable.slack pkgs.nixos-unstable-small.slack ] )
    ( pkgs.versions.latestVersion [ pkgs.slack-term pkgs.nixos-unstable.slack-term pkgs.nixos-unstable-small.slack-term ] )
  ];
}
