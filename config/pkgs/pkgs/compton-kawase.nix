{ stdenv, lib, fetchFromGitHub, pkgconfig, uthash, asciidoc, docbook_xml_dtd_45
, docbook_xsl, libxslt, libxml2, makeWrapper, mesa_drivers
, xorg, pixman, libev
, dbus, libconfig, libdrm, libGL, pcre
, meson, ninja
, libxdg_basedir, linuxPackages }:
{ nvidia ? false }:

let
  nvidiaLibs = (linuxPackages.nvidia_x11.override {
    libsOnly = true;
    kernel = null;
  #})
  #.overrideAttrs(oldAttrs: rec {
    #useGLVND = 0;
  });
  xorgLibs = with xorg; [
    xorgproto
    libxcb
    libX11
    libXext
    xwininfo
    libXinerama
    xcbutilrenderutil
    xcbutilimage
    libXcomposite
    libXdamage
    libXrender
    libXrandr
  ];
  compton-kawase = (stdenv.mkDerivation rec {
    pname = "picom";
    version = "7.3";

    src = (import ../../nix/sources.nix {}).compton-kawase;

    nativeBuildInputs = [
      pkgconfig
      uthash
      asciidoc
      docbook_xml_dtd_45
      docbook_xsl
      makeWrapper
      meson
      ninja
    ];

    buildInputs = [
      dbus
      libdrm pcre libxml2 libxslt libconfig libGL
      libxdg_basedir
      pixman libev
    ]
    ++ xorgLibs
    ;

    NIX_CFLAGS_COMPILE = [ "-fno-strict-aliasing" ];

    installFlags = [ "PREFIX=$(out)" ];

    hardeningDisable = [ "format" ];

    postInstall = if nvidia then ''
        wrapProgram $out/bin/picom \
        --set LD_LIBRARY_PATH "${nvidiaLibs}/lib"
    '' else ''
        wrapProgram $out/bin/picom \
        --set LIBGL_DRIVERS_PATH "${mesa_drivers}/lib/dri"
    '';
    meta = with lib; {
      description = "A fork of XCompMgr, a sample compositing manager for X servers";
      longDescription = ''
          A fork of XCompMgr, which is a sample compositing manager for X
          servers supporting the XFIXES, DAMAGE, RENDER, and COMPOSITE
          extensions. It enables basic eye-candy effects. This fork adds
          additional features, such as additional effects, and a fork at a
          well-defined and proper place.
      '';
      license = licenses.mit;
      homepage = "https://github.com/tryone144/compton";
      maintainers = with maintainers; [ evanjs ];
      platforms = platforms.linux;
    };
  });
in compton-kawase
