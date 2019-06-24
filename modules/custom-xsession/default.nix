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
  xmonadHaskellPackages = with pkgs.haskellPackages; [
    xmonad-contrib
    mtl
    containers
    dbus
    dbus-hslogger
    #gtk3
    rate-limit
    status-notifier-item
    time-units
    xml-helpers
    spool
    X11
    xmobar
    xmonad
    xmonad-wallpaper
  ];
in
  {
    imports = [
      ../virtualgl.nix
    ];

    environment.systemPackages = with pkgs; [
      arandr
      (xmonad-with-packages.override {
        packages = self: with self; [
          gcc
          libxml2
          pkgconfig
          upower
          x11
          xmonad-log
          hicolor-icon-theme
        ]
        ++ xorgPkgs;
      })

      #(taffybar.override {
        #packages = self: with self; [
        #]
        #++ xmonadHaskellPackages;
      #})

      haskellPackages.xmobar

      trayer
      rofi
      xscreensaver
      maim
      xlockmore
      xtrlock-pam
      xclip
      xorg.xbacklight
      xdotool
      notification-daemon
      #taffybar
    ];

    sound.mediaKeys.enable = true;

    services.hoogle.packages = hp: with pkgs.haskellPackages; [ ] ++ xmonadHaskellPackages;

    services.xserver = {
      desktopManager.xterm.enable = false;
      exportConfiguration = true;
      windowManager = {
        default = "xmonad";
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = hp: with pkgs.haskellPackages; [ ] ++ xmonadHaskellPackages;
        };
      };

    };

    services.compton = {
      vSync = true;
    };
  }

