{ config, pkgs, lib, ... }:
{
  imports = [
    ./evanjs
    ./hie-nix
    ./rjg
  ]
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else [])
  ;
}


