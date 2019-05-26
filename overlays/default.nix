{ config, pkgs, lib, ... }:
{
  imports = [
    ./evanjs
    ./hie-nix
    ./nur
    ./rjg
  ]
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else [])
  ;
}


