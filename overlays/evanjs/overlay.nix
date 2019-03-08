self: super:
let
  callPackage = self.callPackage;
  callQPackage = self.libsForQt5.callPackage;
in 
  {
    booru = callPackage ./pkgs/booru { };
    cross = callPackage ./pkgs/cross { };
    exercism = callPackage ./pkgs/tools/exercism { };
    kivy = callPackage ./pkgs/python/kivy { python = self.python37; };
    kivy-garden = callPackage ./pkgs/python/kivy-garden { python = self.python37; };
    polychromatic = callPackage ./pkgs/polychromatic { };
    qrbooru = callQPackage ./pkgs/qrbooru { };
    rrbg = callPackage ./pkgs/rrbg { };
    runescape-launcher = callPackage ./pkgs/runescape-launcher { };
    rust-qt-binding-generator = callQPackage ./pkgs/rust-qt-binding-generator { };
    sccache = callPackage ./pkgs/tools/sccache { };
  }
