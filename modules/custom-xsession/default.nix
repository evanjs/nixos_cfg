{ config, pkgs, lib, ... }:
let
  notification-daemon-pkg = pkgs.notify-osd;
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
        ];
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

    services.xserver = {
      desktopManager.xterm.enable = false;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
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

