{ config, pkgs, lib, ... }:
let
  notification-daemon = pkgs.notify-osd-customizable;
in
  {
    imports = [
      ./xmonad
    ];

    home.packages = with pkgs; [
      arandr
      haskellPackages.xmobar
      maim
      notification-daemon
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
      pointerCursor = {
        name = "Breeze";
        package = pkgs.plasma5.breeze-gtk;
        defaultCursor = "left_ptr";
      };
    };
  }
