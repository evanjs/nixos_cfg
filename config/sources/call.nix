{ file }:
let
  pkgs = import <nixpkgs> {
    overlays = [(self: super: {
    })];
  };
  lib = pkgs.lib;
in pkgs.callPackage file {} // {
    inherit file;
}
