{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    arandr
    #(xmonad-with-packages.override {
      #packages = self: with self; [
        #taffybar
        #xmonad-contrib
        #xmonad-extras
        #xmobar
      #];
    #})
    (haskellPackages.ghcWithPackages (self: with self; [
      mtl
      xmonad
      xmonad-contrib
      xmonad-extras
      xmobar
      taffybar
      cabal-install
      lens
      curl

      # taffybar
      gi-atk
      gi-cairo
      gi-dbusmenu
      gi-dbusmenugtk3
      gi-gdk
      gi-gdkpixbuf
      gi-gio
      gi-glib
      gi-gobject
      gi-gtk
      gi-gtk-hs
      gi-pango
      gi-xlib
      gtk-sni-tray
      gtk-strut
      haskell-gi
    ]))
  ];
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      tapping = true;
    };


    desktopManager.xterm.enable = false;
    videoDrivers = [ "intel" ];
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
      use-ewmh-active-win   = true;
      detect-transient      = true;
      paint-on-overlay      = true;
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
