self: super:
let
  pkgs = import <nixpkgs> { };
  callPackage = pkgs.lib.callPackageWith ( pkgs // self);
  self = {
    versions = pkgs.callPackage ./versions.nix { version = super.version; };
    helpers = pkgs.callPackage ./helpers.nix { };
  };
in
  self
