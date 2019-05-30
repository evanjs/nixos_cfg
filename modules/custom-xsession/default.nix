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
          taffybar
        ]
        ++ xorgPkgs;
      })
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
    ];

    sound.mediaKeys.enable = true;

    services.xserver = {
      desktopManager.xterm.enable = false;
      exportConfiguration = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = with pkgs.haskellPackages;
        haskellPackages: [
          xmonad-contrib
          mtl
          containers
          dbus
          dbus-hslogger
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
      };
      windowManager.default = "xmonad";
    };

    services.compton = {
      backend         = "glx";
      enable          = true;
      extraOptions    = ''
          unredir-if-possible   = true;
          use-ewmh-active-win   = false;
          detect-transient      = false;
          paint-on-overlay      = true;
          xinerama-shadow-crop  = true;
      '';
      fade            = true;
      inactiveOpacity = "0.9";
      shadow          = true;
      fadeDelta       = 4;
      fadeExclude = [
        "name = 'Screenshot'"
        "class_g = 'slop'"
      ];
      shadowExclude = [
        "name = 'Screenshot'"
        "class_g = 'slop'"
        "name = 'Notification'"
      ];

      vSync = true;
    };
  }

