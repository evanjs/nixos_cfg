{ config, pkgs, lib, ... }:
let
  xmonadDir = ".xmonad";
in
  {
    imports = [
      ./lib.nix
    ];

    home.file = {
      "my-xmonad.cabal" = rec {
        source = ./my-xmonad.cabal;
        target = "${xmonadDir}/my-xmonad.cabal";
      };
      "stack.yaml" = rec {
        source = ./stack.yaml;
        target = "${xmonadDir}/stack.yaml";
      };
      "refresh" = rec {
        source = ./refresh;
        target = "${xmonadDir}/refresh";
      };
    };
  }
