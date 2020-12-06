{ config, pkgs, lib, ... }:
{
  imports = [
    ./evanjs
    ./haskell
    ./libs
    ./rjg/nix/rjg-overlay.nix
  ]
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else [])
  ;
}


