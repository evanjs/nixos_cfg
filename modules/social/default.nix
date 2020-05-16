{ config, pkgs, ... }:
{
  imports = [
    ./discord.nix
    ./slack.nix
    ./weechat.nix
  ];

  environment.systemPackages = with pkgs; [
    riot-desktop
    gitter
  ];
}
