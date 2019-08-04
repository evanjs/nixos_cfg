{ config, pkgs, ... }:
{
  imports = [
    ./discord.nix
    ./slack.nix
    ./weechat.nix
  ];
}
