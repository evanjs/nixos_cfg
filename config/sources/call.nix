{ file }:
let
  pkgs = import ../../external/nixpkgs {
    overlays = [(self: super: {
    })];
  };
  lib = pkgs.lib;
in pkgs.callPackage file {} // {
    inherit file;
}
