{ config, pkgs, lib, ... }:
{
  imports = [
    ./evanjs
    ./hie-nix
    ./nur
    ./libs
    ./rjg
  ]
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else [])
  ;
}


