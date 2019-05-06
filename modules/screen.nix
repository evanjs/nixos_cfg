{ config, pkgs, ... }:
{
  programs.screen = {
    screenrc = ''
    # Enable mouse scrolling and scroll bar history scrolling
      termcapinfo xterm* ti@:te@
    '';
  };
}
