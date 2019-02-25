self: super:
let
  pkgs = import <nixpkgs> { };
  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // self);

  self = {
    gitkraken = callPackage ./pkgs/gitkraken { };
    kivy = callPackage ./pkgs/python/kivy { python = self.python37; };
    kivy-garden = callPackage ./pkgs/python/kivy-garden { python = self.python37; };
    exercism = callPackage ./pkgs/tools/exercism { };
    sccache = callPackage ./pkgs/tools/sccache { };
  };
in
  self

