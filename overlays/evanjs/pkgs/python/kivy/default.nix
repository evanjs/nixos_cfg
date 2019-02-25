{ stdenv
, callPackage
, docutils
, gcc
, python
, mesa
, libGL
, pkgconfig
, opencv # camera ? false
#, garden ? false
, gstreamer # gstreamer ? false
, SDL2 #, sdl ? false
, spell ? false
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
    USE_SDL2=1;
    USE_GSTREAMER=1;

    nativeBuildInputs = [
      docutils
      libGL
      mesa
      kivy-garden
      pkgconfig
      gstreamer
      SDL2
    ];

    pythonPath = with python.pkgs; [
      kivy-garden
      cython
      pygments
      requests
    ];

    doCheck = false;
  }
