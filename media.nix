{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # photo viewers
    feh
    digikam5

    # music players
    amarok

    # video players
    mplayer
    vlc

    # bpm indexing
    mixxx
  ];
}
