self: super:
let
  moz_overlay = import (builtins.fetchGit https://github.com/mozilla/nixpkgs-mozilla.git );
  unstable = import <nixpkgs-unstable> { overlays = [ moz_overlay ]; };
  unstableRustPlatform = unstable.rustPlatform;
  unstableRust = unstable.latest.rustChannels.stable.rust;
  unstableCargo = unstable.latest.rustChannels.stable.cargo;
  callPackage = self.callPackage;
  callPackages = self.callPackages;
  callQPackage = self.libsForQt5.callPackage;
in 
  {
    booru = callPackage ./pkgs/booru { };
    cross = callPackage ./pkgs/cross { };
    exercism = callPackage ./pkgs/tools/exercism { };
    kivy = callPackage ./pkgs/python/kivy { python = self.python37; };
    kivy-garden = callPackage ./pkgs/python/kivy-garden { python = self.python37; };
    kivymd = callPackage ./pkgs/python/kivymd { python = self.python37; };
    material-ui = callPackage ./pkgs/python/material-ui { python = self.python37; };
    mcdex = callPackage ./pkgs/games/mcdex { };
    nightly-rust-with-extensions = callPackage ./pkgs/nightly-rust { };
    nget = callPackage ./pkgs/nget { };
    polychromatic = callPackage ./pkgs/polychromatic { };
    qrbooru = callQPackage ./pkgs/qrbooru { };
    rrbg = callPackage ./pkgs/rrbg { };
    runescape-launcher = callPackage ./pkgs/runescape-launcher { };
    rust-qt-binding-generator = callQPackage ./pkgs/rust-qt-binding-generator { };
    sccache = callPackage ./pkgs/tools/sccache { };
  }
