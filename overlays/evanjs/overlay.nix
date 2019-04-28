self: super:
let
  callPackage = self.callPackage;
  callPackages = self.callPackages;
  callQPackage = self.libsForQt5.callPackage;
in 
  {
    booru = callPackage ./pkgs/booru { };
    cross = callPackage ./pkgs/cross { };
    exercism = callPackage ./pkgs/tools/exercism { };
    copenssl = callPackages ./pkgs/openssl { };
    libwebsockets = callPackage ./pkgs/libwebsockets { openssl = self.copenssl.openssl_1_1; };
    qrbooru = callQPackage ./pkgs/qrbooru { };
    rrbg = callPackage ./pkgs/rrbg { };
    runescape-launcher = callPackage ./pkgs/runescape-launcher { };
    rust-qt-binding-generator = callQPackage ./pkgs/rust-qt-binding-generator { };
    sccache = callPackage ./pkgs/tools/sccache { };
  }
