self: super:
let
  callPackage = self.callPackage;
  callQPackage = self.libsForQt5.callPackage;
in 
  {
    cross = callPackage ./pkgs/cross { };
    kivy = callPackage ./pkgs/python/kivy { python = self.python37; };
    kivy-garden = callPackage ./pkgs/python/kivy-garden { python = self.python37; };
    exercism = callPackage ./pkgs/tools/exercism { };
    runescape-launcher = callPackage ./pkgs/runescape-launcher { };
    sccache = callPackage ./pkgs/tools/sccache { };
    rrbg = callPackage ./pkgs/rrbg { };
    polychromatic = callPackage ./pkgs/polychromatic { };
    rust-qt-binding-generator = callQPackage ./pkgs/rust-qt-binding-generator { };
    booru = callPackage ./pkgs/booru { };
    qrbooru = callQPackage ./pkgs/qrbooru { };
  }
