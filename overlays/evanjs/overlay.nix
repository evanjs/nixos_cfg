self: super:
let
  callPackage = self.callPackage;
  callPackages = self.callPackages;
  callQPackage = self.libsForQt5.callPackage;
in 
  {
    booru = callPackage ./pkgs/booru { };
    copenssl = callPackages ./pkgs/openssl { };
    cross = callPackage ./pkgs/cross { };
    exercism = callPackage ./pkgs/tools/exercism { };
    fake-useragent = callPackage ./pkgs/python/fake-useragent { };
    kivy = callPackage ./pkgs/python/kivy { python = self.python37; };
    kivy-garden = callPackage ./pkgs/python/kivy-garden { python = self.python37; };
    kivymd = callPackage ./pkgs/python/kivymd { python = self.python37; };
    material-ui = callPackage ./pkgs/python/material-ui { python = self.python37; };
    nget = callPackage ./pkgs/nget { };
    libwebsockets = callPackage ./pkgs/libwebsockets { openssl = self.copenssl.openssl_1_1; };
    polychromatic = callPackage ./pkgs/polychromatic { };
    qrbooru = callQPackage ./pkgs/qrbooru { };
    rrbg = callPackage ./pkgs/rrbg { };
    runescape-launcher = callPackage ./pkgs/runescape-launcher { };
    rust-qt-binding-generator = callQPackage ./pkgs/rust-qt-binding-generator { };
    sccache = callPackage ./pkgs/tools/sccache { };
  }
