{ stdenv, callPackage, buildFHSUserEnv }:

buildFHSUserEnv rec {
  name = "runescape-launcher";

  runScript = "${callPackage ./runtime.nix {}}/bin/runescape-launcher";

  targetPkgs = pkgs: with pkgs // pkgs.xorg; [
    libSM
    libX11
    libXxf86vm
    libpng12
    glib
    glib_networking
    pango
    cairo
    gdk_pixbuf
    curl
    gtk2
    expat
    SDL2
    zlib
    glew110
    mesa
    libglvnd
    xdg_utils
    coreutils
    firefox
    xclip
    which
  ];
}
