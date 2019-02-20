{ config, pkgs, ... }:
{

  imports = [
    ./unstable.nix
    ];

  environment.systemPackages = with pkgs; [
    arandr
    #xmonad
    #xmobar
    (xmonad-with-packages.override {
      packages = self: with self; [
        #taffybar
        xmonad-contrib
        xmonad-extras
        haskellPackages.xmobar
      ];
    })
    #cairo
    #(taffybar.override {
      #packages = self: with self; [
      #gi-atk
      #gi-cairo
      #gi-dbusmenu
      #gi-dbusmenugtk3
      #gi-gdk
      #gi-gdkpixbuf
      #gi-gio
      #gi-glib
      #gi-gobject
      #gi-gtk
      #gi-gtk-hs
      #gi-pango
      #gi-xlib
      #gtk-sni-tray
      #gtk-strut
      #haskell-gi
      #haskellPackages.download-curl
    #];
  #})

  #(haskellPackages.ghcWithPackages (self: with self; [
    #xmonad-wallpaper
    #xmobar
  #]))

    (haskellPackages.ghcWithPackages (self: with self; [
      mtl
      xmonad
      xmonad-contrib
      xmonad-extras
      xmonad-wallpaper
      xmobar
      #taffybar
      gi-cairo
      gi-gdkx11
      cabal-install
      lens
      curl
    ]))
  ];
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      tapping = true;
    };


    desktopManager.xterm.enable = false;
    videoDrivers = [ "intel" "nvidia" ];
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
