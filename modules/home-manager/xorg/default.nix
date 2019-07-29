{ config, pkgs, lib, ... }:
{
  imports = [
    ./xmonad
  ];

  home.packages = with pkgs; [
    arandr
    haskellPackages.xmobar
    maim
    rofi
    trayer
    xclip
    xdotool
    xlockmore
    xorg.xbacklight
    xscreensaver
    xtrlock-pam
  ];
  xsession = {
    enable = true;
    pointerCursor = {
      name = "breeze_cursors";
      package = pkgs.plasma5.breeze-qt5;
    };
  };
}
