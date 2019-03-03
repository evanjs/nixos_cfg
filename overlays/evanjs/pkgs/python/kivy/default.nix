{ stdenv
, cairo
, callPackage
, docutils
, gcc
, python
, mesa
, mesa_drivers
, mesa_noglu
, mesa_glu
, libGL
, libGL_driver
, pkgconfig
, opencv # camera ? false
#, garden ? false
, gstreamer # gstreamer ? false
, mtdev
, SDL2 #, sdl ? false
, SDL2_image
, SDL2_gfx
, SDL2_mixer
, SDL2_ttf
, spell ? false
, xlibs
, xlibsWrapper
}:

let
  kivy-garden = python.pkgs.toPythonModule ((callPackage ../../python/kivy-garden { }).override {
    python = python;
  });
  #kivy-garden = callPackage ../../python/kivy-garden { python = python; };
in
  python.pkgs.buildPythonPackage rec {
    pname = "kivy";
    version = "1.10.1";

    src = python.pkgs.fetchPypi {
      inherit version;
      pname = "Kivy";
      sha256 = "7ce9e88b75de47a3f1d52cbe6924c18cafc83fa102e54f6794d241746e93fdff";
    };

    KIVY_USE_SETUPTOOLS=1;
    USE_X11 = 1;
    USE_SDL2 = 1;
    USE_GSTREAMER = 1;
    #USE_MESAGL = 1;

    nativeBuildInputs = [
      docutils
      
      #libGL
      #mesa
      #mesa_drivers
      #mesa_glu
      #mesa_noglu
      #libGL_driver

      kivy-garden
      pkgconfig
      xlibsWrapper
      SDL2
      SDL2_image
      SDL2_mixer
      SDL2_ttf
      mtdev
    ];

    propogatedBuildInputs = [
      SDL2
      SDL2_image
      SDL2_mixer
      SDL2_ttf

      #libGL
      #mesa
      #mesa_drivers
      #mesa_glu
      #mesa_noglu
      #libGL_driver

      xlibs.libXrender # if x11 true
      xlibs.libX11 # if x11 true
      python.pkgs.gst-python  
      cairo
      python.pkgs.pillow
      python.pkgs.pycairo
      mtdev
      #gstreamer
    ];

    postPatch = ''
      substituteInPlace kivy/lib/mtdev.py --replace "cdll.LoadLibrary('libmtdev.so.1')" "cdll.LoadLibrary('${mtdev.outPath}/lib/libmtdev.so.1')"
    '';

    pythonPath = with python.pkgs; [
      kivy-garden
      cython
      pygments
      requests
      pysdl2
      pycairo
      pillow
      gst-python
      #pygame
    ];

    doCheck = false;
  }
