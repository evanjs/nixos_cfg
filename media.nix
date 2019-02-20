{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # photo viewers
    digikam5
    feh

    # music players
    #amarok

    # video players
    vlc
    mplayer

    # bpm indexing
    #mixxx
  ];
}
