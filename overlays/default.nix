{ config, pkgs, lib, ... }:
{
  imports = [
    ./evanjs
    ./haskell
    ./libs
    ./rjg
  ]
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else [])
  ;
}


