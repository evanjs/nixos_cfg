{ config, pkgs, lib, ... }:
let
  notification-daemon = pkgs.notify-osd-customizable;
  xorgPkgs = with pkgs.xorg; [
    libX11
    libXext
    libXinerama
    libXrandr
    libXrender
    libXft
  ];
in
  {
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
      windowManager = {
        xmonad = {
          config = ./xmonad.hs;
          enable = true;
          enableContribAndExtras = true;
          extraPackages = hp: with pkgs; [
            gcc
            libxml2
            pkgconfig
            upower
            x11
            xmonad-log
            hicolor-icon-theme
          ]
          ++ xorgPkgs;

          haskellPackages = pkgs.haskell.packages.ghc865;
          #(haskellPackages: with haskellPackages; [
            #mtl
            #containers
            #dbus
            #dbus-hslogger
            #rate-limit
            #status-notifier-item
            #time-units
            #xml-helpers
            #spool
            #X11
            #xmobar
            #xmonad
            #xmonad-wallpaper
          #]);
        };
      };
    };
  }
