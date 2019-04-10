{ config, pkgs, lib, ... }:
let
  notification-daemon-pkg = pkgs.notify-osd;
  xorgpkgs = with pkgs.xorg; [
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
          xmonad-contrib
          xmonad-extras
          gcc
          libxml2
          pkgconfig
          upower
          x11
          #haskellPackages.lens
          #haskellPackages.xmonad-contrib
          #haskellPackages.mtl
          #haskellPackages.containers
          #haskellPackages.dbus
          #haskellPackages.dbus-hslogger
          #haskellPackages.rate-limit
          #haskellPackages.status-notifier-item
          #haskellPackages.time-units
          #haskellPackages.xml-helpers
          #haskellPackages.spool
          #haskellPackages.X11
          #haskellPackages.xmobar
        ]
        ++ xorgpkgs;
      })
      haskellPackages.xmobar
      
      xmonad-log
      trayer
      rofi
      xscreensaver
      maim
      xtrlock-pam
      xclip
      xorg.xbacklight
      xdotool
    ];
    
    sound.mediaKeys.enable = true;

    services.xserver = {
      desktopManager.xterm.enable = false;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.lens
          haskellPackages.xmonad-contrib
          haskellPackages.mtl
          haskellPackages.containers
          haskellPackages.dbus
          haskellPackages.dbus-hslogger
          haskellPackages.rate-limit
          haskellPackages.status-notifier-item
          haskellPackages.time-units
          haskellPackages.xml-helpers
          haskellPackages.spool
          haskellPackages.X11
          haskellPackages.xmobar
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

        vSync = "opengl-swc";
      };
    }

